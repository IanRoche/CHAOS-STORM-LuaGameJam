local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Player =Player or require "src.Player"

local m_Player

function Scene:new()
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed)
    print("Game")
end

function Scene:update(dt)
    m_Player:update(dt)

    if love.keyboard.isDown(ExitKey) then
        ChangeScene("GameOver")
    end
end

function Scene:draw()
    m_Player:draw()
end

return Scene