# cocos2dx_lua_skynet_client   
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

# 编译项目   

# 开启skynet服务器 进行通信测试。  

skynet服务器地址：https://github.com/gameloses/skynet_pbc.git 