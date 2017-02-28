local NetMgr = class("NetMgr")

local socket = require("socket")

local scheduler = cc.Director:getInstance():getScheduler() 

function NetMgr:ctor()
    self.is_connected = false
    self.send_task_list = {}
end

function NetMgr:getInstance()
    if not self.instance_ then
        print("getInstance()")
        self.instance_ = NetMgr:new() 
    end
    return self.instance_
end

function NetMgr:connect(ip, port)
    self.ip = ip
    self.port = port
    self.socket_ = socket.tcp();  
    self.socket_:settimeout(0);   --非阻塞
    self.socket_:setoption("tcp-nodelay", true)  --去掉优化
    self.socket_:connect(self.ip, self.port);    --链接

    local function checkConnect(dt)
        --停止定时器
        if self:isConnected() then
            self.is_connected = true

            scheduler:unscheduleScriptEntry(self.scheduler_id);
            
            self.precess_id = scheduler:scheduleScriptFunc(function( ... )
                self:processSocketIO()
            end, 0.05)
        end
    end 
    self.scheduler_id = scheduler:scheduleScriptFunc(checkConnect, 0.05)
end

function NetMgr:stop()
    scheduler:unscheduleScriptEntry(self.precess_id);
end

function NetMgr:isConnected()
    local for_write = {};
    table.insert(for_write,self.socket_);
    local ready_forwrite;
    _,ready_forwrite,_ = socket.select(nil,for_write,0);
    if #ready_forwrite > 0 then
        return true;
    end
    return false;
end

function NetMgr:processSocketIO()
    if not self.is_connected then
        return
    end
    self:processInput()
    self:processOutput()
end

function NetMgr:processInput()
    --检测是否有可读的socket
    local recvt, sendt, status = socket.select({self.socket_}, nil, 1)
    print("input", #recvt, sendt, status)
    if #recvt <= 0 then
        return;
    end

    --先接受两个字节计算包的长度
    local buffer, err = self.socket_:receive(2);
    if buffer then
        --计算包的长度 
        local first, sencond = string.byte(buffer,1,2);
        local len=first * 256 + sencond; --通过位计算长度
        print("收到数据长度=",len)

        --接受整个数据
        local buffer, err = self.socket_:receive(len);

        --解析包
        local pb_len, pb_head, pb_body, t = string.unpack(buffer, ">PPb"); 
        local msg_head = protobuf.decode("PbHead.MsgHead", pb_head) 
        local msg_body = protobuf.decode(msg_head.msgname, pb_body)
        print("收到服务器数据", msg_head.msgname)

        dump(msg_head)
        dump(msg_body)
    end
end

function NetMgr:processOutput()
    if self.send_task_list  and #self.send_task_list > 0 then
        local data = self.send_task_list[#self.send_task_list]
        if data then
            local _len ,_error = self.socket_:send(data);  
            print("socket send"..#data, "_len:", _len, "error:", _error)
            --发送长度不为空，并且发送长度==数据长度
            if _len ~= nil and _len == #data then
                table.remove(self.send_task_list, #self.send_task_list)
            else

            end
        end
    end
end

function NetMgr:send(msg_name, msg_body)
    --拼装头
    local msg_head={msgtype = 1, msgname = msg_name, msgret = 0};
    local pb_head = protobuf.encode("PbHead.MsgHead", msg_head)
    local pb_body = protobuf.encode(msg_name, msg_body);
    --计算长度
    local pb_head_len = #pb_head;
    local pb_body_len = #pb_body;
    local pb_len = 2 + pb_head_len + 2 + pb_body_len + 1; 

    local data = string.pack(">HPPb",pb_len, pb_head, pb_body, string.byte('t'));
    print("GameNet send msg:"..msg_name..":"..string.char(string.byte('t')))

    table.insert(self.send_task_list, 1, data)
end

return NetMgr