import sqlite3
import os
from sqlite3 import Error

def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        conn.close()
if __name__ == '__main__':
    create_connection('C:\\CISP253\mydatabase.db')

def create_table(conn, create_table_sql):
    try:
        c = conn.cursor()
        c.execute(create_table_sql)
    except Error as e:
        print(e)
def main():
    database = 'C:\CISP253 - PL files\mydatabase.db'

    sql_create_system_information_table = ''' CREATE TABLE system_information (
                                                machine_name text,
                                                kernel_version text,
                                                product_type text,
                                                product_version text,
                                                registered_organization text,
                                                registered_owner text,
                                                system_root text,
                                                processors text,
                                                physical_memory text
                                            );'''
    sql_create_software_installed_table = ''' CREATE TABLE software_installed (
                                                machine_name text,
                                                software_installed text
                                            );'''
    sql_create_process_list_table = ''' CREATE TABLE process_list (
                                        machine_name text,
                                        process_name text, 
                                        pid text
                                    );'''
    conn = create_connection(database)
    if conn is not None:
        create_table(conn, sql_create_system_information_table)
        create_table(conn, sql_create_software_installed_table)
        create_table(conn, sql_create_process_list_table)
    else:
        print('Error')
    if __name__ == '__main__':
        main()

def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except Error as e:
        print(e)
    return None

os.system('psinfo.exe -S >system_information.db')
os.system('psinfo.exe -S >software_installed.db')
os.system('pslist.exe >process_list.db')

print('Sending data over to .csv file now...')

os.system('psinfo.exe -S >system_information.csv')
os.system('psinfo.exe -S >software_installed.csv')
os.system('pslist.exe >process_list.csv')





