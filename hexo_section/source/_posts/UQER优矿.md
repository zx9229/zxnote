---
title: UQER优矿
categories:
  - 软件相关
toc: false
date: 2019-09-01 02:06:38
tags:
---
UQER(优矿)允许邮箱注册账号，我很喜欢！
<!-- more -->

* 优矿的一个使用示例
[如何下载股票历史数据？ - Myles的回答 - 知乎](https://www.zhihu.com/question/22145919/answer/76852520)。  

* Python
```
pip install numpy
pip install pandas
```

* 建表语句
```sql
CREATE TABLE uqer_fund_daily(
secID             VARCHAR(32),
ticker            VARCHAR(32),
exchangeCD        VARCHAR(32),
secShortName      VARCHAR(256),
tradeDate         DATE           NOT NULL,
preClosePrice     DECIMAL(30,10),
openPrice         DECIMAL(30,10),
highestPrice      DECIMAL(30,10),
lowestPrice       DECIMAL(30,10),
closePrice        DECIMAL(30,10),
CHG               DECIMAL(30,10),
CHGPct            DECIMAL(30,10),
turnoverVol       DECIMAL(30,10),
turnoverValue     DECIMAL(30,10),
discount          DECIMAL(30,10),
discountRatio     DECIMAL(30,10),
circulationShares DECIMAL(30,10),
accumAdjFactor    DECIMAL(30,10),
INDEX idx1(secID, ticker, exchangeCD, tradeDate)
);
```

* LOAD DATA
[LOAD DATA Syntax](https://dev.mysql.com/doc/refman/5.7/en/load-data.html)。  
```sql
LOAD DATA LOCAL INFILE '文件名'
    IGNORE INTO TABLE 表名
    FIELDS TERMINATED BY ','  ENCLOSED BY '' ESCAPED BY ''
    LINES  TERMINATED BY '\n' STARTING BY ''
    IGNORE 数字 LINES
    [(col_name_or_user_var [, col_name_or_user_var] ...)]
    [SET col_name={expr | DEFAULT}, [, col_name={expr | DEFAULT}] ...]
```
