# 计网知识点总结 Week 3 (应用层概述)


## 1. 网络应用原理
### 1.1 进程
- 定义：在主机中运行的程序 program running within a host
- 在同一个主机中，两个进程之间的通信采用inter-process communication 
- 在不同主机中，进程之间通信依靠exchange messages
- 客户端和服务端进程：
  - client process: process that initiates communication
  - server process: process that waits to be contacted

### 1.2 socket 套接字
> 套接字是主机内应用层和传输层之间的接口，也称为应用程序编程接口(API Application Programming Interface)。
- socket类似于门
  - 发送过程将消息推到室外 
  - 发送过程依靠门另一侧的传输基础设施在接收过程中将消息传递到套接字 
  - 有两个socket:两边各一个
![socket](1.PNG "socket")

### 1.3 如何识别网络进程
- 使用IP地址和端口号
- ”五元组“：发送者、接收者的IP address和port number以及underlying transport protocol
- 不一样的进程使用不一样的端口，例如:HTTP服务器:80，邮件服务器:25 
- 知名端口Well-known vs.临时ephemeral 端口
  - 服务器有一个众所周知的端口(例如，端口80)
    - 0到1023之间(需要root用户使用)
  - 客户端选择一个未使用的临时(即临时)端口
    - 1024到65535之间
    - Registered ports: Range from 1,024–49,151
    - Dynamic/Private ports: Range from 49,152–65,535

### 1.4 应用层定义了什么
- 交换信息的类型 **types of messages exchanged**
  - request/response
- 信息的语法 **message syntax**
  - 消息中有哪些字段、如何描述字段
- 消息语义 **message semantics** 
  - 字段中信息的含义
- 进程发送和响应消息的时间和方式的规则rules
- 开放协议 **open protocols**
  - 在RFC中定义了，每个人都可以访问协议
  - 允许互操作性
  - e.g. HTTP，SMTP
- 专有协议 **proprietary protocols**
  - 与特定的产品相关联
  - e.g. 无线通信

### 1.5 应用需要什么样的传输服务
- 数据完整性 **data integrity**
  - 某些应用程序（例如，文件传输，网络交易）需要100%可靠的数据传输
  - 其他应用程序（例如音频）可以容忍一些损失
- 即时性 **timing**
  - 某些应用（例如，互联网电话、互动游戏）需要低延迟才能“有效”
- 吞吐量 **throughput**
  - 某些应用（例如多媒体）具有吞吐量要求，例如，要“有效”的最小吞吐量
  - 其他应用（“弹性应用”）利用它们获得的任何吞吐量
- 安全 **security**
  - 加密， 数据完整性

### 1.6 TCP和UDP
- TCP服务
  - 发送和接收过程之间的可靠传输
  - 流量控制flow control：发送方不会压倒接收方sender won’t overwhelm receiver 
  - 拥塞控制congestion control：网络过载时限制发送方throttle sender when network overloaded
  - 面向连接connection-oriented：需要通过握手过程在客户端和服务器进程之间进行设置setup required between client and server processes through handshaking procedure
  - 不提供：计时、最小吞吐量保证、安全性 does not provide timing, minimum throughput guarantee, security
- UDP服务
  - 发送和接收过程之间的数据传输不可靠unreliable data transfer 
  - 不提供does not provide：可靠性、流量控制、拥塞控制、timing、吞吐量保证、安全性或连接设置。

### 2. 使用TCP和UDP进行套接字编程
- UDP编程实例
  - client
    ```python
    from socket import *
    serverName = ‘hostname’
    serverPort = 12000
    clientSocket = socket(AF_INET, SOCK_DGRAM)
    message = raw_input(’Input lowercase sentence:’)
    clientSocket.sendto(message.encode(), (serverName, serverPort))
    modifiedMessage, serverAddress = clientSocket.recvfrom(2048)
    print modifiedMessage.decode()
    clientSocket.close()
    ```
  - server
    ```python
    from socket import *
    serverPort = 12000
    serverSocket = socket(AF_INET, SOCK_DGRAM)
    serverSocket.bind(('', serverPort))
    print (“The server is ready to receive”)
    while True:
        message, clientAddress = serverSocket.recvfrom(2048)
        modifiedMessage = message.decode().upper()
        serverSocket.sendto(modifiedMessage.encode(), clientAddress)
    ```
- TCP编程实例
  - client
    ```python
    from socket import *
    serverName = ’servername’
    serverPort = 12000
    clientSocket = socket(AF_INET, SOCK_STREAM)
    clientSocket.connect((serverName,serverPort))
    sentence = raw_input(‘Input lowercase sentence:’)
    clientSocket.send(sentence.encode())
    modifiedSentence = clientSocket.recv(1024)
    print (‘From Server:’, modifiedSentence.decode())
    clientSocket.close()
    ```
  - server
    ```python
    from socket import *
    serverPort = 12000
    serverSocket = socket(AF_INET,SOCK_STREAM)
    serverSocket.bind((‘’,serverPort))
    serverSocket.listen(1)
    print ‘The server is ready to receive’
    while True:
        connectionSocket, addr = serverSocket.accept()
        
        sentence = connectionSocket.recv(1024).decode()
        capitalizedSentence = sentence.upper()
        connectionSocket.send(capitalizedSentence.encode())
        connectionSocket.close()
    ```

## 3. 应用体系结构
### 3.1 client-server paradigm
- server: 
  - always-on host 始终在线
  - permanent IP address 永久的IP地址 
  - often in data centers, for scaling 在数据中心
- clients:
  - contact, communicate with server 与服务器通信
  - may be intermittently connected 不一定是持久连接
  - may have dynamic IP addresses 可能有动态IP地址
  - do not communicate directly with each other 客户端互相之间不直接通信
- e.g. Web、email、FTP

### 3.2 P2P paradigm (对等体结构)
- 没有始终在线的服务器 no always-on server
- 任意终端系统直接通信
- 对等节点向其他对等方请求服务，提供服务以换取其他对等方
- 对等体间歇性连接并更改 IP 地址
- 示例：P2P 文件共享（比特流）、网络语音（Skype）

#### 3.2.1 P2P文件分发: BitTorrent
- 文件被分成256kb的数据块
- peer在比特流中发送和接受文件块
- Peer加入torrent:
  - 一开始没有块，但是将会通过其他节点处累积文件块
  - 向跟踪服务器注册，获得peer节点列表，和部分peer节点构成邻居关系 (“连接”)
- 当peer下载时，该peer可以同时向其他节点提供上载服务
- Peer可能会变换用于交换块的peer节点
- 扰动churn: peer节点可能会上线或者下线
- 一旦一个peer拥有整个文件，它会（自私的）离开或者保留（利他主义）在torrent中

#### 3.2.2 BitTorrent 的优点和缺点
- 优点：
  - 开始时下载速度有点慢，但随着对等方获得越来越多的块，下载速度会大大加快
  - 那些想要文件的人，必须做出贡献
  - 将大文件分发到大量客户端的有效机制
- 缺点：
  - 低带宽客户端有缺点吗？
  - 最稀有的第一个策略可能会导致系统不稳定

## 4. Web和HTTP
### 4.1 一些术语
- Web页：由一些对象组成
- 对象可以是HTML文件、JPEG图像、Java小程序、声音剪辑文件等
- Web页含有一个基本的HTML文件，该基本HTML文件又包含若干对象的引用（链接）
  - 通过URL对每个对象进行引用 访问协议，用户名，口令字，端口等；
  - 计算文件数量，一个html文件引用了5张图片，那么文件的数量是？ 6=5+1（html也算）
- URL格式：Prot://user:psw@www.someSchool.edu/someDept/pic.gif:port
  - 协议名 + 用户：口令 + 主机名 + 路径名 + 端口

### 4.2 HTTP概况
![HTTP](2.png "HTTP")
- HTTP：超文本传输协议 Hypertext transfer protocol
- Web的应用层协议
  - 客户/服务器模式 
    - 客户: 请求、接收和显示Web对象的浏览器 
    - 服务器: 对请求进行响应，发送对象的Web服务器
- 使用TCP:
  - 客户发起一个与服务器的TCP连接 (建立套接字) ，端口号为 80
  - 服务器接受客户的TCP连接
  - 在浏览器(HTTP客户端) 与 Web服务器(HTTP服务器 server)交换HTTP报文 (应用层协议报文) 
  - TCP连接关闭
- HTTP是无状态的stateless：服务器并不维护关于用户的任何信息。

### 4.3 HTTP连接
#### 4.3.1 非持久HTTP和持久HTTP
- 非持久HTTP
  - 最多只有一个对象在TCP连接上发送
  - 下载多个对象需要多个TCP连接
  - HTTP/1.0使用非持久连接
![非持久HTTP](3.png "非持久HTTP")

- 持久HTTP “pipeline流水线”
  - 多个对象可以在一个（在客户端和服务器之间的）TCP连接上传输
  - HTTP/1.1默认使用持久连接
![持久HTTP](4.png "持久HTTP")

#### 4.3.2 HTTP报文
- HTTP请求报文
```shell
GET /index.html HTTP/1.1\r\n
Host: www-net.cs.umass.edu\r\n
User-Agent: Firefox/3.6.10\r\n
Accept: text/html,application/xhtml+xml\r\n
Accept-Language: en-us,en;q=0.5\r\n
Accept-Encoding: gzip,deflate\r\n
Accept-Charset: ISO-8859-1,utf-8;q=0.7\r\n
Keep-Alive: 115\r\n
Connection: keep-alive\r\n
\r\n
```
![请求报文格式](5.png "请求报文格式")

  - 请求行：
    - GET(从服务器获取)
    - POST(发送到服务器)
    - HEAD(debug)
    - PUT(将文件上载到指定路径)
  - 请求头：：
    - User-Agent 浏览器版本
    - Accept：浏览器能够接收的资源类型  
    - Accept-Encoding：浏览器支持的压缩类型，
    - Accept-Language 浏览器偏好的语言
    - Host：请求主机名称
  - message内容使用ASCII

- HTTP响应报文

