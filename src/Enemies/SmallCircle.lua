local Object = Object or require "lib.classic"

local SmallCircle = Object:extend()

function SmallCircle:new(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius / 3
    self.image = love.graphics.newImage("src/Textures/Enemies/Allahakbar/explosion2.png")
    self.scale = self.radius * 2 / self.image:getWidth()

    self.speed = 20
    self.angle = love.math.random() * (2 * math.pi)

    table.insert(EnemyList, self)
end

function SmallCircle:update(dt)
    self:updatePosition(dt)
end

function SmallCircle:updatePosition(dt)
    self.x = self.x + self.speed * math.cos(self.angle) * dt
    self.y = self.y + self.speed * math.sin(self.angle) * dt
end

function SmallCircle:draw()
    love.graphics.draw(self.image, self.x - self.image:getWidth() * self.scale / 2,
        self.y - self.image:getHeight() * self.scale / 2, 0, self.scale, self.scale)
end

function SmallCircle:checkCollisionWithPlayer(player)
    local distance = math.sqrt((self.x - player.x) ^ 2 + (self.y - player.y) ^ 2)
    local minDistance = self.radius + player.radius
    return distance <= minDistance
end

return SmallCircle
