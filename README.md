# openGauss与PostgreSQL的对比分析

## 一．实验目的
本次实验旨在从性能，可靠性和安全性等方面，通过实验验证比较与评估openGauss和PostgreSQL数据库，推测两个数据库在实验结果中产生差别的可能原因，进而分析openGauss的优缺点。

## 二．实验环境
### 软件环境
使用的PostgreSQL版本：12.1，openGauss版本：3.0.0（通过拉取docker镜像部署）

### 硬件环境
- CPU：12th-Intel Core i7-12700H
- 操作系统：Windows11

## 三．代码使用
1. **DatabaseThroughputTest.java**: 用java程序模拟多线程并发测试openGauss和postgreSQL的吞吐量。
2. **simple.sql**: 用于比较两个数据库执行大量命令时的执行时间，命令包括更新操作，插入操作，删除操作，共200000条简单命令。
3. **complex.sql**: 用于比较两个数据库执行相同的复杂查询命令时的执行时间。
4. **acid.sql**: 用于测试openGauss的acid特性。

## 四．实验过程和报告
详见report.docx
