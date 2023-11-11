local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Score = require "src.Score"

local m_Score

function Scene:new()
    m_Score = Score()
    print("GameOver")
    self.finalScore = m_Score.score  -- Variable para almacenar la puntuación final
end

function Scene:update(dt)
    if love.keyboard.isDown(ExitKey) then
        love.event.quit('restart')
    end
    for i, rgb in ipairs(BackGroundColor) do
        BackGroundColor[i] = BackGroundColor[i] - 0.001
    end
end

function Scene:draw()
    love.graphics.setColor(GameOverColor)
    self:drawGameOverText()
    self:drawScoreText()
    self:drawRestartText()
    love.graphics.setColor(1, 1, 1)
end

function Scene:drawGameOverText()
    love.graphics.setFont(love.graphics.newFont(GameOverFontSize))
    local gameOverText = "GAME OVER"
    local textWidth = love.graphics.getFont():getWidth(gameOverText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(gameOverText, (screenWidth - textWidth) / 2, screenHeight / 2 - GameOverFontSize)
end

function Scene:drawScoreText()
    love.graphics.setFont(love.graphics.newFont(MenuFontSize))
    local scoreText = "Puntuación: " .. self.finalScore
    local scoreWidth = love.graphics.getFont():getWidth(scoreText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(scoreText, (screenWidth - scoreWidth) / 2, screenHeight / 2)
end

function Scene:drawScoreMotivationText()
    love.graphics.setFont(love.graphics.newFont(MenuFontSize))
    local motivationText = "Dev record: 26, si superas el record, VOTANOS"
    local motivationWidth = love.graphics.getFont():getWidth(motivationText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(motivationText, (screenWidth - motivationWidth) / 2, screenHeight / 3 )
end

function Scene:drawRestartText()
    love.graphics.setFont(love.graphics.newFont(GameoverEscFontSize))
    local restartText = "Press ESC to restart"
    local restartWidth = love.graphics.getFont():getWidth(restartText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(restartText, (screenWidth - restartWidth) / 2, screenHeight / 3 * 2 + GameoverEscFontSize)
end

return Scene
