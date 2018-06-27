# PhysicalKeyGenerate
保存使用Zigbee进行秘钥生成的代码
## 单片机开发环境安装
安装的软件见环境配置，详细过程见环境配置中的[STM8开发环境安装说明](https://github.com/deadfishlovecat/PhysicalKeyGenerate/tree/master/%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE)

### 入门实验 
记录新手在学习过程中做的一些实验，通过这些实验，可以更好了解开发。
#### 实验一 代码烧写
##### 实验要求
了解STM8的原理图，知道各个引脚的作用。原始的工程文件综合了发送和接收功能，使用两块板子分别烧录接收和发送程序，测试数据传输是否正常。

##### 工程代码解析
- Include Files/app/main.h

通过预编译调整接收发送模式选择以及软件硬件SPI选择
- Source Files/app/main.h
  - 1 初始化
   
   首先对串口、LED、SPI以及CC1101进行初始化，并红灯和绿灯同时闪烁3次表明成功。
   - 2 发送代码
    
    首先通过检查是否需要切换模式，如果切换到固定发送模式就会红灯闪烁3次，否则会绿灯闪烁三次。然后根据发送的数据进行发送。

   - 3 接收代码
   将接收到的数据直接发送给串口


