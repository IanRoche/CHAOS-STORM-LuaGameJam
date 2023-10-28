local Object = Object or require "lib.classic"
local Scene = Object:extend()

function Scene:new()
    print("GameOver")
end

function Scene:update(dt)
    if love.keyboard.isDown(ExitKey) then
        ChangeScene("Menu")
    end
end

function Scene:draw()
end

return Scene