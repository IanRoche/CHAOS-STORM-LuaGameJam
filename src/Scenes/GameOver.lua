local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Score = require "src.Score"

local m_Score

function Scene:new()
    m_Score = Score()
    self.finalScore = m_Score.score
    self.gameOverFont = love.graphics.newFont(GameOverFontSize)
    self.menuFont = love.graphics.newFont(MenuFontSize)
    self.gameoverEscFont = love.graphics.newFont(GameoverEscFontSize)
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
    -- Establecer el color de fondo negro
    love.graphics.setBackgroundColor(0, 0, 0)
    self:drawElements()
end

function Scene:drawElements()

    if self.finalScore >= ScoreToLevel5 then
        self:drawImage("ener")

    elseif self.finalScore >= ScoreToLevel4 then
        self:drawImage("kid")

    elseif self.finalScore >= ScoreToLevel3 then
        self:drawImage("tecnocampus")

    elseif self.finalScore >= ScoreToLevel2 then
        self:drawImage("krater")

    else    
        self:drawImage("JaumeTeEstimu")
    end

    -- Dibujar elementos
    love.graphics.setColor(GameOverColor)
    self:drawText("GAME OVER", self.gameOverFont, -GameOverFontSize)
    self:drawText("Puntuación: " .. self.finalScore, self.menuFont, 0)
    self:drawText("¡Si superas el TUTORIAL, votanos!", self.menuFont, love.graphics.getHeight() / 5)
    self:drawText("Press ESC to restart", self.gameoverEscFont, love.graphics.getHeight() / 3 * 2 + GameoverEscFontSize)
    love.graphics.setColor(1, 1, 1)
end

function Scene:drawText(text, font, yOffset)
    love.graphics.setFont(font)
    local textWidth = font:getWidth(text)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.print(text, (screenWidth - textWidth) / 2, screenHeight / 2 + yOffset)
end

function Scene:drawImage(imagePath)
    local image = love.graphics.newImage("src/Textures/" .. imagePath .. ".png")
    local x = love.graphics.getWidth() / 2 - image:getWidth() / 2
    local y = love.graphics.getHeight() / 2 - image:getHeight() / 2
    love.graphics.draw(image, x, y)
end

return Scene
