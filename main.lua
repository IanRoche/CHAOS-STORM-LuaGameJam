local Data = Data or require ("src/data")
Collider = require "lib.ColliderMaster.collider"
local Scene
local scene



function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  if arg[#arg] == "vsc_debug" then require("lldebugger").start() end -- Enable the debugging with vscode
  ChangeScene("Menu")
  Data:load()

end

function love.update(dt)
  scene:update(dt)
end

function love.draw()
  scene:draw()
end

function ChangeScene(nextScene)
  Scene = require("src/Scenes/"..nextScene)
  scene = Scene()
end