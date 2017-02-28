cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"

local function main()
    --require("app.MyApp"):create():run()
    
    --初始化pbc	
    require("pbc.pbc")

    --测试代码
    require("test.test")

end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
