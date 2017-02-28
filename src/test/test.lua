

print "测试pbc"

local msg_head = {msgtype = 1, msgname ="PbLogin.MsgLoginReq" , msgret = 0}
local encode_head_data = protobuf.encode("PbHead.MsgHead", msg_head)
print("#encode_head_data", #encode_head_data)

local decode_head_data = protobuf.decode("PbHead.MsgHead", encode_head_data)
print("decode_head_data.msgname", decode_head_data.msgname)


print "lpack"

--encode head
local msg_head={msgtype = 1, msgname = "PbLogin.MsgLoginReq", msgret = 0};
local pb_head = protobuf.encode("PbHead.MsgHead", msg_head)

--encode body
local msg_body = {platform = 1, user_id = 111}
local pb_body = protobuf.encode("PbLogin.MsgLoginReq", msg_body);

--计算长度
local pb_head_len = #pb_head;
local pb_body_len = #pb_body;
local pb_len = 2 + pb_head_len + 2 + pb_body_len + 1; 

local data = string.pack(">HPPb", pb_len, pb_head, pb_body, string.byte('t'));
print("data", #data)

local ret, len, head_data, body_data, char_data = string.unpack(data, ">HPPb")
print(ret, len, #head_data, #body_data, string.char(char_data))

print(ret, len)
local ret_head_data = protobuf.decode("PbHead.MsgHead", head_data)
dump(ret_head_data)
local ret_body_data = protobuf.decode("PbLogin.MsgLoginReq", body_data)
dump(ret_body_data)


print("测试网络链接")

local ip = 127.0.0.1
local port = 8000

local NetMgr = require("net.NetMgr")
local net = NetMgr:getInstance()

print("链接")
net:connect(ip, port)
print("发送数据")
net:send("PbLogin.MsgLoginReq", {platform = 1, user_id = "sun"})




