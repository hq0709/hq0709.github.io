# 计网知识点总结 Week 6 (TCP拥塞控制)


## 看懂这张图就可以了
![牛逼的图](2.PNG "牛逼的图")

## TCP拥塞控制的版本
- TCP Tahoe
  - This is the original version of TCP congestion control
  - Slow Start
  - Fast Retransmit 
- TCP Reno
  - Same as Tahoe, but with Fast Recovery 有快速恢复
- TCP Vegas
  - This is a completely new implementation based on delay variation (instead of packet loss) 基于延迟变化

