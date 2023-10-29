local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Score = require "src.Score"  

local m_Score

function Scene:new()
    m_Score=Score()
    print("GameOver")
    self.finalScore = m_Score.score  
    -- Variable para almacenar la puntuación final
end


function Scene:update(dt)
    if love.keyboard.isDown(ExitKey) then
        ChangeScene("Menu")
    end
end

function Scene:draw()
    love.graphics.setColor(GameOverColor)

    -- Dibuja "GAME OVER" en el centro de la pantalla
    love.graphics.setFont(love.graphics.newFont(GameOverFontSize))
    local gameOverText = "GAME OVER"
    local textWidth = love.graphics.getFont():getWidth(gameOverText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(gameOverText, (screenWidth - textWidth) / 2, screenHeight / 2 - GameOverFontSize)

    -- Dibuja la puntuación debajo de "GAME OVER"
    love.graphics.setFont(love.graphics.newFont(MenuFontSize))
    local scoreText = "Puntuación: " .. self.finalScore

    local scoreWidth = love.graphics.getFont():getWidth(scoreText)
    love.graphics.print(scoreText, (screenWidth - scoreWidth) / 2, screenHeight / 2)

    love.graphics.setColor(1, 1, 1)
end

return Scene
