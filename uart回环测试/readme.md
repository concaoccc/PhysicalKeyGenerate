### 回环测试
本工程是进行UART的回环测试。
##### 从机(RX)
等待uart接收到的数据，然后通过zigbee发送出去。等到ZigBee回发的数据后然后将数据通过UART回发

#####主机(TX)
等待ZigBee接收到数据，然后通过UART发送回上位机。上位机通过串口回发数据，然后通过Zigbee发送回去

##### 上位机程序
上位机为test中的uart_master_test.py和uart_slave_test.py