# 计网知识点总结 Week 5 (传输层概述)


## 1. 传输层综述
### 1.1 功能
- provide **logical communication** between application processes running on different hosts 注意是在不同主机上运行的应用进程
- transport protocols implemented in end systems not in routers 在终端系统中实现，不是路由器 （路由器只有Network，Datalink，Physical）
- TCP和UDP是两种传输层协议
  - TCP提供的服务：
    - reliable, in-order delivery
    - congestion control 
    - flow control
    - connection setup
  - UDP是不可靠的传输

### 1.2 传输层服务
- Connection oriented service 面向连接的服务
  - connection set-up, data transfer, disconnect 
- Connectionless service 
  - isolated unit 独立单元的传输

### 1.3 传输层的任务
- 将上层与子网的技术、设计和缺陷（imperfections）隔离开来
- 在（可靠）数据传输服务的提供者和用户之间建立主要界限（major boundary）

### 1.4 传输层的目的
- To **Improve the Network Service quality** that users and layers want to get from the network layer
- 通过传输实体（transport entity）实现

## 1.5 一些传输层功能（细化）
- Multiplexing/de-multiplexing data for multiple applications 
- Uses “port’’ abstraction
- Error control 
- End-to-end flow control 
- Congestion control 

## 2. Multiplexing/demultiplexing 多路复用/多路分解
### 2.1 



