require("src.pbc.protobuf")

protobuf.register_pb = function(filename)
    local buffer = read_file_c(filename)
    protobuf.register(buffer)
end

local proto_conf = {
    "src/proto/pbhead.pb",
    "src/proto/pblogin.pb",
}

protobuf.load_proto = function()
    for _,v in pairs(proto_conf) do
        protobuf.register_pb(v)
    end
end

protobuf.load_proto()