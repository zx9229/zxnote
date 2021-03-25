import argparse
import logging
import sqlalchemy


def sqlalchemy_localhost_3306():
    params = {"name_or_url": "mysql+pymysql://root:toor@localhost:3306/zxdb?local_infile=1", "encoding": "utf8", "echo": True}
    return params


def initConnection_sqlalchemy(*args, **kwargs) -> sqlalchemy.engine.base.Connection:
    '''
    前缀: mysql,         使用MySQLdb, 可能需要[pip install MySQL-python]安装依赖;
    前缀: mysql+pymysql, 使用pymysql, 可能需要[pip install pymysql]安装依赖;
    params = { "name_or_url":         "mysql://用户:密码@主机:端口/数据库?local_infile=1", "encoding": "utf8", "echo": False}
    params = { "name_or_url": "mysql+pymysql://用户:密码@主机:端口/数据库?local_infile=1", "encoding": "utf8", "echo": False}
    params = { "name_or_url": "sqlite:///./test.db", "encoding": "utf8", "echo": False}
    connection = initConnection_sqlalchemy(**params)
    '''
    sqlalchemy_engine = sqlalchemy.create_engine(*args, **kwargs)
    sqlalchemy_connection = sqlalchemy_engine.connect()
    return sqlalchemy_connection


def test_create_table(connection: sqlalchemy.engine.base.Connection):
    sql_statement = 'DROP TABLE IF EXISTS tb_test;'
    connection.execute(sql_statement)
    sql_statement = '''
    CREATE TABLE tb_test(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tkey        VARCHAR(512)    NOT NULL DEFAULT '',
    tvalue      VARCHAR(512)    NOT NULL DEFAULT '',
    insert_time DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );'''
    connection.execute(sql_statement)


def test_insert(connection: sqlalchemy.engine.base.Connection):
    sql_statement = '''INSERT INTO tb_test(tkey, tvalue) VALUES ('k1','v1'), ('k2','v2');'''
    connection.execute(sqlalchemy.text(sql_statement))

    sql_statement = '''INSERT INTO tb_test(tkey, tvalue) VALUES (%s, %s);'''  # MySQL的占位符是[%s], SQLite的占位符是[?]
    connection.execute(sql_statement, ('k3', 'v3'), ('k4', 'v4'))

    sql_statement = '''INSERT INTO tb_test(tkey, tvalue) VALUES (%s, %s),(%s, %s);'''
    connection.execute(sql_statement, 'k5', 'v5', 'k6', 'v6')


def test_update(connection: sqlalchemy.engine.base.Connection):
    sql_statement = '''UPDATE tb_test SET tvalue='v1_update' WHERE tkey='k1';'''
    connection.execute(sql_statement)


def test_transaction_1(connection: sqlalchemy.engine.base.Connection):
    transaction: sqlalchemy.engine.base.RootTransaction = connection.begin()
    sql_statement = '''UPDATE tb_test SET tvalue='v2_update' WHERE tkey='k2';'''
    connection.execute(sql_statement)
    transaction.rollback()

    transaction: sqlalchemy.engine.base.RootTransaction = connection.begin()
    sql_statement = '''UPDATE tb_test SET tvalue='v3_update' WHERE tkey='k3';'''
    connection.execute(sql_statement)
    transaction.commit()


def test_transaction_2(connection: sqlalchemy.engine.base.Connection):
    try:
        with connection.begin() as transaction:
            sql_statement = '''UPDATE tb_test SET tvalue='v4_update' WHERE tkey='k4';'''
            connection.execute(sql_statement)
            logging.info('[point1] transaction.is_active = {}'.format(transaction.is_active))
            transaction.rollback()
            logging.info('[point2] transaction.is_active = {}'.format(transaction.is_active))

            sql_statement = '''UPDATE tb_test SET tvalue='v5_update' WHERE tkey='k5';'''
            logging.info('[point3]')
            connection.execute(sql_statement)
            logging.info('[point4] transaction.is_active = {}'.format(transaction.is_active))
            transaction.commit()
            logging.info('[point5] transaction.is_active = {}'.format(transaction.is_active))
    except Exception as ex:
        logging.info('在[point3]和[point4]之间有COMMIT日志, 说明transaction此时已经失效了')
        logging.exception(ex)
        logging.info('看来, transaction只能被显式地rollback或commit一次, 然后它就非active了')


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.DEBUG)
    params = sqlalchemy_localhost_3306()
    connection = initConnection_sqlalchemy(**params)

    test_create_table(connection)
    test_insert(connection)
    test_update(connection)
    test_transaction_1(connection)
    test_transaction_2(connection)

    connection.close()
