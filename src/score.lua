local Object = Object or require "lib.classic"
local Score = Object:extend()
local tutorialTime
local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

function Score:new()
    self.score = _Score
    self.font = love.graphics.newFont(24)
    self.timeElapsed = 0
    self.pointsPerSecond = 1
    tutorialTime = true
end

function Score:update(dt)
    self:handleTimeElapsed(dt)
    self:updateScoreToLevel2()
end

function Score:handleTimeElapsed(dt)
    self.timeElapsed = self.timeElapsed + dt 

    if self.timeElapsed >= 1 then
        self:increaseScore(self.pointsPerSecond)  
        self.timeElapsed = self.timeElapsed - 1 
    end
end

function Score:updateScoreToLevel2()
    if _Score > ScoreToLevel2 and tutorialTime == true then
        tutorialTime = false
        _Score = 0
    end
end

function Score:increaseScore(points)
    _Score = _Score + points
end

function Score:draw()
    love.graphics.setFont(self.font)

    if tutorialTime then
        local text = "Tutorial"
        local textWidth = love.graphics.getFont():getWidth(text)
        
        local x, y = self:getCenteredPosition(textWidth, 10)
        
        love.graphics.setColor(1, 0.5, 0)
        love.graphics.print(text, x, y, 0, 1.5, 2)
    else
        local scoreText = "Puntuación: " .. _Score
        self:drawCentered(scoreText)
    end
end

function Score:GetScore()
    return _Score
end

function Score:drawCentered(text)
    local textWidth = love.graphics.getFont():getWidth(text)
    local x, y = self:getCenteredPosition(textWidth, 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, x, y)
end

function Score:getCenteredPosition(textWidth, yOffset)
    local x = (screenWidth - textWidth) / 2
    local y = yOffset
    return x, y
end

return Score
