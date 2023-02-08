# 计网知识点总结 Week 7 & 8 (网络层)


## 1. 网络层服务和协议
- communication service
  - sender: encapsulates segments into datagrams, passes to link layer
  - receiver: delivers segments to transport layer protocol
- 每个设备的网络层协议在host和routers中
- 路由器检查每一个通过的IP数据报的header fields，把数据报从输入端口发送到输出端口

## 2. IPv4 & addressing
### 2.1 IP数据报
![IP datagram](1.png "IP datagram")

### 2.2 IP datagram的分段和重组
![IP datagram的分段和重组](2.png "IP datagram的分段和重组")
- 不同的链路有不同的MTU(max transmission unit)，所以IP datagram有时会进行分段，IP header bits用来识别和定位，分段后的碎片在目的地进行重组
![IP datagram重组的例子](3.png "IP datagram重组的例子")

### 2.3 IP addressing
![IP aadressing](4.png "IP addressing")
- interface: connection between host/router and physical link 接口的定义
  - 路由器有多个接口，主机有1-2个接口
- IP address与每个接口对应，32位（每个数字是八位二进制数）

### 2.4 subnet
- definition: device interfaces that can physically reach each other without passing through an intervening router 无需经过路由器就能到达彼此
- 子网有相同的高阶位（common high order bits），不同的低阶位（主机号），注意主机号不能全为0或者全为1

#### 2.4.1 subnet mask 子网掩码
- 比如/24 就代表32位中的前24位代表子网地址，后面代表主机号

#### 2.4.2 有多少子网？
![11](5.png "有多少子网（/24）")
- 6个

#### 2.4.3 CIDR: Classless InterDomain Routing 
![CIDR example](6.png "CIDR example")

### 2.5 关于IP的补充
- ISP怎样得到地址块？
{{< admonition type=tip title="Answer" open=false >}}
ICANN: Internet Corporation for Assigned  Names and Numbers http://www.icann.org/
{{< /admonition >}}
- 有足够的32位IP地址吗
{{< admonition type=tip title="Answer" open=false >}}
2011年已经分配完了最后一个32位IP地址

IPv6有128位IP地址
{{< /admonition >}}
- 路由聚合：增多子网掩码的位数

### 2.6 IPv6
- 八组四个16进制数字
![IPv6数据报](7.png "IPv6数据报")
- IPv4和IPv6之间的网络如何建立？
  - tunneling: IPv6 datagram carried as payload in IPv4 datagram among IPv4 routers (“packet within a packet”) IPv4里面包一个IPv6
![tunneling](8.png "tunneling")

## 3. DHCP: Dynamic Host Configuration Protocol 
- 分配子网的主机号，动态的向服务器请求一个IP
- 运行在UDP/IP上
- 一般由ISP/LANs/organizational networks使用
![DHCP server](9.png "DHCP server and client")
- server 和 client之间的连接一般由四个步骤
  - client: DHCP discover
  - server: DHCP offer
  - client: DHCP request
  - server: DHCP ACK
- DHCP can return more than just allocated IP address on subnet:
  - address of first-hop router for client 客户端第一跳的路由器
  - name and IP address of local DNS sever 本地DNS服务器的名称和IP
  - network mask (indicating network versus host portion of address) 这个是什么，子网掩码吗

### 3.1 DHCP连接过程描述
![DHCP连接过程描述](10.png "DHCP连接过程描述")
- 连接的笔记本电脑将通过DHCP获取IP地址，first-hop路由器地址，DNS服务器地址、
- UDP封装DHCP REQUEST报文，IP封装DHCP REQUEST报文，以太网封装DHCP REQUEST报文
- 以太网帧广播(dest: ffffffffff)在局域网上，由运行DHCP服务器的路由器接收
- 从以太网提取IP数据报，从IP数据报提取UDP，从UDP提取DHCP REQUEST消息
- DHCP服务器制定DHCP ACK，包含客户端的IP地址、客户端的first-hop路由器IP地址、DNS服务器的名称和IP地址
- 封装的DHCP服务器回复转发给客户端，demuxing到客户端DHCP
- 客户端现在知道它的IP地址，DNS服务器的名称和IP地址，它的first-hop路由器的IP地址

### 3.2 DHCP报文
![DHCP message](11.png "DHCP message")

### 3.3 DHCP的优点
- Relieves the network administrator of manual configuration 无需手动配置
- Devices can be moved from network to network and automatically obtain valid configuration parameters for the current network 设备可以在网络之间移动，自动获取当前网络的有效配置参数
- IP addresses are only allocated when needed 只在需要的时候分配IP地址

### 3.4 DHCP的局限性
- 需要DHCP server
- 安全问题
  - Uses UDP, an unreliable and insecure protocol
  - DHCP is an unauthenticated(未经身份验证的) protocol

## 4. NAT: Network Address Translation 
![NAT](12.png "NAT")
- Local network uses just one IP address as far as outside world is concerned 本地网络内部只使用一个IP地址
- 解决了地址短缺的问题

### 4.1 NAT的优点
- just one IP address needed from provider ISP for all devices 只需要ISP提供一个IP地址
- can change addresses of devices in local network without notifying outside world 在不通知外界的情况下修改内部地址
- can change ISP without changing addresses of devices in local network 在不更改网络设备的条件下更换ISP
- security: devices inside local net not directly addressable, visible by outside world 本地网络中的设备无法直接寻址 ？？？

### 4.2 NAT的实现
![NAT实现](13.png "NAT实现")
- 需要 NAT router
- 传入、传出的时候把外部的IP和端口转换为NAT IP和新的端口
- 在NAT translation table中存储对应的IP - NAT IP关系

### 4.3 NAT的争议性
- routers “should” only process up to layer 3 ？？？
- address “shortage” should be solved by IPv6
- violates(违反) end-to-end argument
- NAT traversal: what if client wants to connect to server behind NAT ？？？



