import pandas as pd
from sqlalchemy import create_engine, text
from datetime import datetime
import time

DB_USER = "root"
DB_PASS = "Evans1030*" 
DB_HOST = "localhost"
DB_NAME_SRC = "db_sumber"
DB_NAME_DWH = "dwh"
FILE_EXCEL = "transaction_excel.xlsx"
FILE_EXCEL_FALLBACK = "transaction_excel.xlsx - Sheet1.csv"
FILE_CSV = "transaction_csv.csv"

engine_src = create_engine(f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME_SRC}")
engine_dwh = create_engine(f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME_DWH}")

def format_seconds(seconds):
    return f"{seconds:.2f}s"

def print_step_done(step_name, start_time, rows=None, extra=None):
    duration = time.perf_counter() - start_time
    rows_info = f" | rows={rows}" if rows is not None else ""
    extra_info = f" | {extra}" if extra else ""
    print(f"[OK] {step_name}{rows_info} | time={format_seconds(duration)}{extra_info}")

def log_to_db(status, message="", start_time=None, log_id=None):
    try:
        current_time = datetime.now()
        with engine_dwh.connect() as conn:
            if status == "START":
                query = text("INSERT INTO etl_log (process_name, start_time, status, message) VALUES ('ETL_Full_Process', :t, 'RUNNING', 'ETL Started')")
                conn.execute(query, {'t': current_time})
                conn.commit()
                return conn.execute(text("SELECT LAST_INSERT_ID()")).scalar(), current_time
            
            elif log_id:
                duration = (current_time - start_time).total_seconds()
                query = text("UPDATE etl_log SET end_time = :end, status = :stat, message = :msg, duration_seconds = :dur WHERE log_id = :id")
                conn.execute(query, {'end': current_time, 'stat': status, 'msg': message, 'dur': duration, 'id': log_id})
                conn.commit()
    except Exception as e:
        print(f"Logging Error: {e}")

def run_etl():
    log_id, start_ts = log_to_db("START")
    total_start = time.perf_counter()
    print(f"=== ETL STARTED AT {start_ts} ===")
    
    try:
        step_start = time.perf_counter()
        with engine_dwh.connect() as conn:
            conn.execute(text("DELETE FROM facttransaction"))
            conn.execute(text("DELETE FROM dimaccount"))
            conn.execute(text("DELETE FROM dimcustomer"))
            conn.execute(text("DELETE FROM dimbranch"))
            conn.commit()
        print_step_done("DWH cleanup", step_start)

        step_start = time.perf_counter()
        df_branch = pd.read_sql("SELECT * FROM branch", engine_src)
        df_branch = df_branch.rename(columns={'branch_id': 'BranchID', 'branch_name': 'BranchName', 'branch_location': 'BranchLocation'})
        df_branch.to_sql('dimbranch', engine_dwh, if_exists='append', index=False)
        print_step_done("dimbranch load", step_start, rows=len(df_branch))

        step_start = time.perf_counter()
        q_cust = "SELECT c.customer_id, c.customer_name, c.address, ci.city_name, s.state_name, c.age, c.gender, c.email FROM customer c JOIN city ci ON c.city_id=ci.city_id JOIN state s ON ci.state_id=s.state_id"
        df_cust = pd.read_sql(q_cust, engine_src)
        df_cust.columns = ['CustomerID', 'CustomerName', 'Address', 'CityName', 'StateName', 'Age', 'Gender', 'Email']
        for col in ['CustomerName', 'Address', 'CityName', 'StateName', 'Gender']:
            df_cust[col] = df_cust[col].astype(str).str.upper()
        df_cust.to_sql('dimcustomer', engine_dwh, if_exists='append', index=False)
        print_step_done("dimcustomer load", step_start, rows=len(df_cust))

        step_start = time.perf_counter()
        df_acc = pd.read_sql("SELECT * FROM account", engine_src)
        df_acc = df_acc.rename(columns={'account_id':'AccountID', 'customer_id':'CustomerID', 'account_type':'AccountType', 'balance':'Balance', 'date_opened':'DateOpened', 'status':'Status'})
        df_acc.to_sql('dimaccount', engine_dwh, if_exists='append', index=False)
        print_step_done("dimaccount load", step_start, rows=len(df_acc))

        step_start = time.perf_counter()
        df_db = pd.read_sql("SELECT * FROM transaction_db", engine_src)
        try:
            df_xl = pd.read_excel(FILE_EXCEL)
        except Exception:
            try:
                df_xl = pd.read_csv(FILE_EXCEL_FALLBACK)
            except Exception:
                df_xl = pd.DataFrame()
        try:
            df_csv = pd.read_csv(FILE_CSV)
        except Exception:
            df_csv = pd.DataFrame()
        
        print(f"[INFO] Sources Read -> DB: {len(df_db)}, Excel: {len(df_xl)}, CSV: {len(df_csv)}")

        df_db['transaction_date'] = pd.to_datetime(df_db['transaction_date'])
        if not df_xl.empty:
            df_xl['transaction_date'] = pd.to_datetime(df_xl['transaction_date'])
        if not df_csv.empty:
            df_csv['transaction_date'] = pd.to_datetime(df_csv['transaction_date'], dayfirst=True)

        df_fact = pd.concat([df_db, df_xl, df_csv], ignore_index=True)
        initial_count = len(df_fact)
        df_fact = df_fact.drop_duplicates(subset=['transaction_id'])
        dup_removed = initial_count - len(df_fact)
        
        valid_ids = pd.read_sql("SELECT AccountID FROM DimAccount", engine_dwh)['AccountID'].tolist()
        before_fk = len(df_fact)
        df_fact = df_fact[df_fact['account_id'].isin(valid_ids)]
        fk_skipped = before_fk - len(df_fact)

        df_fact = df_fact.rename(columns={'transaction_id': 'TransactionID', 'account_id': 'AccountID', 'transaction_date': 'TransactionDate', 'amount': 'Amount', 'transaction_type': 'TransactionType', 'branch_id': 'BranchID'})
        df_fact.to_sql('facttransaction', engine_dwh, if_exists='append', index=False)
        extra = f"dup_removed={dup_removed}, fk_skipped={fk_skipped}"
        print_step_done("facttransaction load", step_start, rows=len(df_fact), extra=extra)

        final_msg = f"Success. dimbranch: {len(df_branch)}, dimcustomer: {len(df_cust)}, dimaccount: {len(df_acc)}, facttransaction: {len(df_fact)}"
        log_to_db("SUCCESS", final_msg, start_ts, log_id)
        
        end_time = datetime.now()
        duration = (end_time - start_ts).total_seconds()
        total_elapsed = time.perf_counter() - total_start
        print(f"=== ETL COMPLETED IN {duration:.2f} SECONDS | total_timer={format_seconds(total_elapsed)} ===")

    except Exception as e:
        print(f"!!! ETL FAILED: {e}")
        log_to_db("FAILED", str(e), start_ts, log_id)

if __name__ == "__main__":
    run_etl()