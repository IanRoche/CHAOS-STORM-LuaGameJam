local Object = Object or require "lib.classic"
local Scene = Object:extend()


function Scene:new()
    self.m_gameOverFont = love.graphics.newFont(GameOverFontSize)
    self.m_menuFont = love.graphics.newFont(MenuFontSize)
    self.m_gameoverEscFont = love.graphics.newFont(GameoverEscFontSize)
end

function Scene:update(dt)
    if love.keyboard.isDown(ExitKey) then
        love.event.quit('restart')
    end
    for i, l_rgb in ipairs(BackGroundColor) do
        BackGroundColor[i] = BackGroundColor[i] - 0.001
    end
end

function Scene:draw()
    -- Establecer el color de fondo negro
    love.graphics.setBackgroundColor(0, 0, 0)
    self:drawElements()
end

function Scene:drawElements()
    self:AssignMeme()
    -- Dibujar elementos
    love.graphics.setColor(GameOverColor)
    self:drawText("GAME OVER", self.m_gameOverFont, -GameOverFontSize)
    self:drawText("Puntuación: " .. _Score, self.m_menuFont, 0)
    self:drawText("¡Si superas el TUTORIAL, vótanos! :)", self.m_menuFont, love.graphics.getHeight() / 3)
    self:drawText("Press ESC to restart", self.m_gameoverEscFont, love.graphics.getHeight() / 2.5)
    love.graphics.setColor(1, 1, 1)
end

function Scene:AssignMeme()
    
    if _Score >= ScoreToLevel5 then
        self:drawImage("ener")
    elseif _Score >= ScoreToLevel4 then
        self:drawImage("kid")
    elseif _Score >= ScoreToLevel3 then
        self:drawImage("tecnocampus")
    elseif _Score >= ScoreToLevel2 then
        self:drawImage("krater")
    else
        self:drawImage("JaumeTeEstimu")
    end
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
