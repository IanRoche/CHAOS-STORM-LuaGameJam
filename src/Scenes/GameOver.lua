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
    -- Establecer el color de fondo negro
    love.graphics.setBackgroundColor(0, 0, 0)
    if self.finalScore >= 20 then
        -- Lógica para puntuaciones mayores o iguales a 23
        self.goImage = love.graphics.newImage("src/Textures/ener.png")
        love.graphics.draw(self.goImage, love.graphics.getWidth()/2-self.goImage.getWidth(self.goImage)/2,love.graphics.getHeight()/2-self.goImage.getHeight(self.goImage)/2)
        
        

    elseif self.finalScore >= 15 then
        -- Lógica para puntuaciones mayores o iguales a 23
        self.goImage = love.graphics.newImage("src/Textures/kid.png")
        love.graphics.draw(self.goImage, love.graphics.getWidth()/2-self.goImage.getWidth(self.goImage)/2,love.graphics.getHeight()/2-self.goImage.getHeight(self.goImage)/2)

        
    elseif self.finalScore >= 10 then
        -- Lógica para puntuaciones mayores o iguales a 10
        self.goImage = love.graphics.newImage("src/Textures/tecnocampus.png")
        love.graphics.draw(self.goImage, love.graphics.getWidth()/2-self.goImage.getWidth(self.goImage)/2,love.graphics.getHeight()/2-self.goImage.getHeight(self.goImage)/2)

        
    elseif self.finalScore >= 5 then
        -- Lógica para puntuaciones mayores o iguales a 5
        self.goImage = love.graphics.newImage("src/Textures/krater.png")
        love.graphics.draw(self.goImage, love.graphics.getWidth()/2-self.goImage.getWidth(self.goImage)/2,love.graphics.getHeight()/2-self.goImage.getHeight(self.goImage)/2)

        
    else    
        -- Lógica para puntuaciones menores a 5
        self.goImage = love.graphics.newImage("src/Textures/JaumeTeEstimu.png")
        love.graphics.draw(self.goImage, love.graphics.getWidth()/2-self.goImage.getWidth(self.goImage)/2,love.graphics.getHeight()/2-self.goImage.getHeight(self.goImage)/2)

    end
   

    -- Dibujar elementos
    love.graphics.setColor(GameOverColor)
    self:new()
    self:drawGameOverText()
    self:drawScoreText()
    self:drawRestartText()
    self:drawScoreMotivationText()
    love.graphics.setColor(1, 1, 1)


    

    -- Restaurar el color de fondo predeterminado
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
    local motivationText = "Si superas el TUTORIAL, votanos!"
    local motivationWidth = love.graphics.getFont():getWidth(motivationText)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.print(motivationText, (screenWidth - motivationWidth) / 2, screenHeight / 5 )
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
