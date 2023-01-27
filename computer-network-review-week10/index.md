# 计网知识点总结 Week 10


## 1. 概述
### 1.1 概念和术语
- nodes 节点：any device that runs a link-layer protocol
  - 包括但不限于：主机，路由器，交换机，wifi接入点
- links 链路：_communication channels_ that connect adjacent nodes along communication path（连接相邻节点的通信信道）
  - 有线
  - 无线
- frame：封装数据报
- 链路层的功能：link layer has responsibility of transferring datagram from one node to physically adjacent node over a link（通过链路将数据报从一个节点传输到物理上相邻的节点）
- different links use different link protocols
  - 每个链路之间的协议是可以不同的，第一段链路可能是无线的，第二段可能是有线的等等。第一段用的协议是wifi，第二段用的是以太网等等
  - 每个链路提供的服务可能是可靠的/不可靠的

### 1.2 链路层提供的服务
- framing, link access: 
- encapsulate datagram into frame, adding header, trailer “MAC” addresses in frame headers identify source, destination (different from IP address!) 通过MAC地址识别，而不是IP
channel access if shared medium


