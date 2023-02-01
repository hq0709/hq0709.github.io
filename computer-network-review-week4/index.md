# 计网知识点总结 Week 3 (应用层：DNS和Email)


## 1. 命名和地址
- 一个网络的命名和地址有IP(IPv4, 4 bits)和Host name(e.g. lancaster.ac.uk)，DNS用来映射主机名和IP。

## 2. DNS: Domain Name System 域名系统
> 分布式分层数据库distributed database 层次化的数据库
> 
> 使用UDP 53号端口
>
> 体现了网络边缘的复杂性 complexity at network’s “edge”

### 2.1 DNS的用处
- 被**其他应用层协议**（例如HTTP和SMTP）用于将主机名转换成IP地址
- 为**互联网中的用户应用程序和其他软件**将主机名转换成底层IP

### 2.2 DNS的结构
![DNS结构](1.png "DNS结构")
