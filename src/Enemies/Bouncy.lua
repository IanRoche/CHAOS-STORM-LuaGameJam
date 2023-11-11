local Object = Object or require "lib.classic"

local Bouncy = Object:extend()
Bouncy.speed = BouncyVelocity
Bouncy.maxWallHits = BouncyMaxWallHits
local allBouncysList = {}

function Bouncy:new()
    self:initPosition()
    self:initProperties()
    table.insert(EnemyList, self)
    table.insert(allBouncysList, self)
end

function Bouncy:initPosition()
    local playerX, playerY = GetPlayerPosition()
    local side = math.random(1, 4)

    if side == 1 then
        self.x, self.y = math.random(0, love.graphics.getWidth()), -20
    elseif side == 2 then
        self.x, self.y = math.random(0, love.graphics.getWidth()), love.graphics.getHeight() + 20
    elseif side == 3 then
        self.x, self.y = -20, math.random(0, love.graphics.getHeight())
    else
        self.x, self.y = love.graphics.getWidth() + 20, math.random(0, love.graphics.getHeight())
    end
end

function Bouncy:initProperties()
    self.angle = math.atan2(GetPlayerPosition() - self.y, GetPlayerPosition() - self.x)
    self.image = love.graphics.newImage("src/Textures/bouncy2.png")
    self.radius = 10
    self.escala = self.radius * 2  / self.image:getWidth()
    self.exploded = false
    self.speed = BouncyVelocity
    self.wallHits = 0
    self.aliveColor = {0, 0, 1}
    self.deadColor = {1, 0, 1, 0}
    self.color = self.aliveColor
end

function Bouncy:update(dt)
    for _, bouncy in ipairs(allBouncysList) do
        local dx, dy = self:getMovementComponents(bouncy, dt)
        self:moveBouncy(bouncy, dx, dy)
        self:updateBouncyState(bouncy)
    end
end

function Bouncy:getMovementComponents(bouncy, dt)
    local dx = math.cos(bouncy.angle) * BouncyVelocity * dt
    local dy = math.sin(bouncy.angle) * BouncyVelocity * dt
    return dx, dy
end

function Bouncy:moveBouncy(bouncy, dx, dy)
    bouncy.x = bouncy.x + dx
    bouncy.y = bouncy.y + dy
end

function Bouncy:updateBouncyState(bouncy)
    if not bouncy.exploded then
        self:checkWallCollisions(bouncy)
        self:updateWallHits(bouncy)
    end
end

function Bouncy:checkWallCollisions(bouncy)
    if bouncy.x < 0 or bouncy.x > love.graphics.getWidth() then
        bouncy.angle = math.pi - bouncy.angle
        bouncy.wallHits = bouncy.wallHits + 1
    end

    if bouncy.y < 0 then
        bouncy.y = 0
        bouncy.angle = -bouncy.angle
        bouncy.wallHits = bouncy.wallHits + 1
    elseif bouncy.y > love.graphics.getHeight() then
        bouncy.y = love.graphics.getHeight()
        bouncy.angle = -bouncy.angle
        bouncy.wallHits = bouncy.wallHits + 1
    end
end

function Bouncy:updateWallHits(bouncy)
    if bouncy.wallHits >= BouncyMaxWallHits then
        bouncy.color = bouncy.deadColor
        bouncy:destroy()
    end
end

function Bouncy:checkCollisionWithPlayer(player)
    if not self.exploded then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        if distance <= minDistance then
            self.exploded = true
        end
        return distance <= minDistance
    end
    return false
end

function Bouncy:draw()
    love.graphics.draw(self.image, self.x - self.image:getWidth() * self.escala / 2, 
    self.y - self.image:getHeight() * self.escala / 2, 0, self.escala, self.escala)
end

function Bouncy:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            table.remove(EnemyList, i)
            break
        end
    end
end

return Bouncy
