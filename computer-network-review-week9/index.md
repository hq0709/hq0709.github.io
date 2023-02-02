# 计网知识点总结 Week 9


## 1. 网络层功能
### 1.1 转发（数据平面的功能）
- 将数据包从路由器的输入移动到适当的路由器输出：move packets from router’s input to appropriate router output

### 1.2 路由（控制平面的功能）
- 确定数据包从源到目的地所采用的路径: determine route taken by packets from source to destination

## 2. 控制平面
> 控制平面执行路由的功能（找出一条路），核心就是计算路由表
> 
> 要么是路由器自己计算路由表，要么通过一个外部的远程控制器统一计算路由表
> 
> 路由器和路由器之间可以通过组件进行通信，交换 包含转发表和其他路由选择信息的报文来实现通信。

### 2.1 构建控制平面的两种方法
#### 2.1.1 per-router 每路由器控制
- 每个路由器中的各个路由算法组件在控制平面中相互作用
![per-router](3.PNG "per-router")

#### 2.1.2 SDN (software defined network) 软件定义网络控制平面
- 远程控制器计算并在路由器中安装转发
![SDN](4.PNG "SDN")

## 3. 路由协议
> 路由协议的目的，确保好的路径
> 
> ”好“代表：最低“成本”，“最快”，“最不拥挤”  “good”: least “cost”, “fastest”, “least congested”

### 3.1 路由算法
#### 3.1.1 路由算法的分类
![路由算法的分类](5.png "路由算法的分类")
- 集中式路由选择算法
  - 具有全局状态信息的算法，一般被称为链路状态算法（Link State， LS）
  - 常用的是Dijkstra's algorithm 
- 分散式路由选择算法
  - 常用改是距离向量算法（Distance-Vector, DV）
- [ ] 静态和动态的区别不知道是什么，对应DV和LS吗

### 3.2 Dijkstra's algorithm
- 是一种LS算法
![Dijkstra's algorithm](6.png "Dijkstra's algorith")

### 3.3 距离矢量算法
- 是一种DV算法
- 三个步骤
  - from time-to-time, each node sends its own distance vector estimate to neighbors
  - when x receives new DV estimate from any neighbor, it updates its own DV using B-F equation
  - under minor, natural conditions, the estimate Dx(y) converge to the actual least cost dx(y) 
- 特点：好消息（权重变小）传的快，坏消息（权重变大）传的慢

### 3.4 LS算法和DV算法的比较
![LS算法和DV算法的比较](7.png "LS算法和DV算法的比较")

## 4. 路由扩展性
> 实践中，不可能所有的路由器都执行相同的路由算法
- 规模：有无数的路由器
  - 一个路由不可能在路由表中存储所有目的地!
  - 路由表交换将淹没链接! routing table exchange would swamp links! 

- 行政自治权:administrative autonomy:
  - 每个运营商ISP都希望能按照自己的想法运行，让外部对内不可见，但是同时能够连接外部的网络。
### 4.1 Internet 用的方法，可拓展的路由
#### 4.1.1 AS autonomous system 自治系统
- 将路由器聚合到称为“自治系统”(as，又称“域”，由ASN号标识)的区域。
- AS中的所有路由器必须运行相同的域内协议
- 不同AS中的路由器可以运行不同的域内路由协议
- 网关路由器 gateway router:位于自身AS的“边缘”，与其他AS中的路由器有连接
- 分成两个，inter-AS 和 intra-AS

#### 4.1.2 AS内部 intra-AS (aka “intra-domain”): 
- 网关执行域间路由(以及域内路由)

##### 4.1.2.1 RIP: Routing Information Protocol 
- 经典DV:每30秒交换一次DV

##### 4.1.2.2 EIGRP: Enhanced Interior Gateway Routing Protocol
- 基于距离矢量的定位算法
- 以前是思科Cisco-proprietary的专利

##### 4.1.2.3 OSPF: Open Shortest Path First  开放最短路优先
> IS-IS协议(ISO标准，不是RFC标准)本质上与OSPF相同

- 标识链路状态
  - 每个路由器将OSPF链路状态广播(直接通过IP而不是使用TCP/UDP)发送到整个AS中的所有其他路由器
  - 多种链路成本指标可能:带宽，延迟
  - 每个路由器都有完整的拓扑结构，采用Dijkstra算法计算转发表
- 安全性:所有OSPF消息都经过验证(防止恶意入侵)

##### 4.1.2.4 层级结构的OSPF
![OSPF层次结构](8.png "OSPF层次结构")
- OSPF能够在一个AS中划分多个区域，形成不同层级
- 如上图，一整个图就是一个AS,OSPF将上图划分成了3个local area 和1个backbone 
backbone必须包含但不限于local area的边界路由器。比如上图中被蓝色包裹，并且分别连接area1,2,3的三个边界路由
- 当报文从local area2 的某个路由器要到local area3 的某个路由器时，先要到local area2的边界路由器，然后由backbone 里的路由器进行计算，再路由转发到area3 的边界路由器，再到area3 的某个路由器。

#### 4.1.3 Inter-AS：AS之间的路由选择
> AS-AS之间的路由协议

##### 4.1.3.1 BGP (Border Gateway Protocol): 边界网关协议
![BGP](9.png "BGP")
- [ ] 这里还记得iBGP和OSPF的区别是什么吗
- [ ] 他说边界routers使用两个连接方式是什么意思，不应该只用eBGP吗

##### 4.1.3.2 BGP messages
- OPEN: opens TCP connection to remote BGP peer and authenticates sending BGP peer
- UPDATE: advertises new path (or withdraws old)
- KEEPALIVE: keeps connection alive in absence of UPDATES; also ACKs OPEN request
- NOTIFICATION: reports errors in previous msg; also used to close connection

##### 4.1.3.3 为什么inter-AS和intra-AS的策略不同
- policy: 
  - inter-AS: admin wants control over how its traffic routed, who routes through its network 
  - intra-AS: single admin, so policy less of an issue
- scale:
  - hierarchical routing saves table size, reduced update traffic
- performance: AS间需要着重考虑策略
  - intra-AS: can focus on performance
  - inter-AS: policy dominates over performance

##### 4.1.3.4 BGP route selection
router may learn about more than one route to destination AS, selects route based on:
- highest local preference value attribute: policy decision（主观的策略选择）
- shortest AS-PATH 
- closest NEXT-HOP router: hot potato routing（随便给）
- additional criteria 
