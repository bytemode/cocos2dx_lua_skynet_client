# 解决的问题 
cocos2dx-lua 使用socket和pbc和skynet完成通信
# 关于
cocos2dx-lua client for skynet 
cocos2dx使用luasocket 和 protobuf 连接skynet.   
本例子没有修改cocos2dx引擎任何代码，只是添加了用于解析protobuf的pbc和   
用于打包解包的lpack.   

skynet消息发送时也会使用lua5.3的string.pack()、string.unpack()。cocos2dx   
的lua版本为5.1因此引入lpack.为了在lua下使用protobuf引入pbc.  

# 下载编译   
git clone https://github.com/gameloses/skynet_pbc.git    

在tools中放入和pbc和lpack。可选项。    
需要的话可以    
git submodule init    
git submodule update    

# 把cocos引擎的cocos2d-x目录放到frameworks下   
cocos2dx 我没有添加submodule. 创建cocos项目就行了。没有对cocos版本依赖。
# 编译项目   
  win32和cocos都已经编译测试过了，下面给出的服务端也已经测试过了。
# 开启skynet服务器 进行通信测试。 

skynet服务器地址：https://github.com/gameloses/skynet_pbc.git 

# 教程
详细的教程见wiki。

# 问题
有问题就提issue.
