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
    self:drawText("Puntuation: " .. _Score, self.m_menuFont, 0)
    self:drawText("¡Si superas el TUTORIAL, vótanos! :)", self.m_menuFont, love.graphics.getHeight() / 3)
    self:drawText("Press ESC to restart", self.m_gameoverEscFont, love.graphics.getHeight() / 2.5)
    love.graphics.setColor(1, 1, 1)
end

function Scene:AssignMeme()
    
    if _Score >= ScoreToLevel5 then
        self:drawImage("ener")
        self:drawImageEasterEgg("pepe", 0.05)
    elseif _Score >= ScoreToLevel4 then
        self:drawImage("kid")
        self:drawImageEasterEgg("bingus", 0.1)
    elseif _Score >= ScoreToLevel3 then
        self:drawImage("tecnocampus")
        self:drawImageEasterEgg("belen", 0.4)
    elseif _Score >= ScoreToLevel2 then
        self:drawImage("krater")
        self:drawImageEasterEgg("mondongo", 0.6)
    else
        self:drawImage("JaumeTeEstimu")
        self:drawImageEasterEgg("SHREK", 0.1)
    end
end

function Scene:drawText(text, font, yOffset)
    love.graphics.setFont(font)
    local textWidth = font:getWidth(text)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.print(text, (screenWidth - textWidth) / 2, screenHeight / 2 + yOffset)
end

function Scene:drawImage(imagePath)
    local image = love.graphics.newImage("src/Textures/BigMemes/" .. imagePath .. ".png")
    local x = love.graphics.getWidth() / 2 - image:getWidth() / 2
    local y = love.graphics.getHeight() / 2 - image:getHeight() / 2
    love.graphics.draw(image, x, y)
end

function Scene:drawImageEasterEgg(imagePath, scale)
    local image = love.graphics.newImage("src/Textures/LitMemes/" .. imagePath .. ".jpg")
    local x = 0
    local y = 0
    local escala = scale or 0.5
    love.graphics.draw(image, x, y, 0, escala, escala)
end

return Scene
