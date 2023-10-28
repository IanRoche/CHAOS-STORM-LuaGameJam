local Object = Object or require "lib.classic"
local Player = Object:extend()

function Player:new(x, y, radius, speed)
    self.x = x
    self.y = y
    self.radius = radius
    self.speed = speed
end

function Player:update(dt)
    self:MovePlayer(dt)
    self:CheckWindowCollisions()

end

function Player:draw()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Player:MovePlayer(dt)
    local speedX = 0
    local speedY = 0

    if love.keyboard.isDown("left") then
        speedX = speedX - 1
    end

    if love.keyboard.isDown("right") then
        speedX = speedX + 1
    end

    if love.keyboard.isDown("up") then
        speedY = speedY - 1
    end

    if love.keyboard.isDown("down") then
        speedY = speedY + 1
    end

    local length = math.sqrt(speedX * speedX + speedY * speedY)
    if length > 0 then
        speedX = speedX / length
        speedY = speedY / length
    end

    self.x = self.x + speedX * self.speed * dt
    self.y = self.y + speedY * self.speed * dt
end

function Player:CheckWindowCollisions()
    local radius = self.radius
    local newX = self.x
    local newY = self.y

    if newX - radius < 0 then
        newX = radius
    elseif newX + radius > love.graphics.getWidth() then
        newX = love.graphics.getWidth() - radius
    end

    if newY - radius < 0 then
        newY = radius
    elseif newY + radius > love.graphics.getHeight() then
        newY = love.graphics.getHeight() - radius
    end

    self.x = newX
    self.y = newY
end

return Player
