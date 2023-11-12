local Object = Object or require "lib.classic"
local EnemyFollow = Object:extend()
local Player = require "src.Player"

function EnemyFollow:new()
    -- Inicializa las propiedades del enemigo seguidor
    self.image = love.graphics.newImage("src/Textures/Enemies/green_fireball.png")
    self.radius = 25
    self.scale = self.radius * 2 / self.image:getWidth()
    self.speed = EnemyFollowVelocity
    self.timeAlive = 0
    self.dead = false

    -- Determina el lado de aparición aleatorio
    self:spawnRandomSide()

    table.insert(EnemyList, self)
end

function EnemyFollow:update(dt)
    if not self.dead then
        self:checkAndDestroyEnemiesCollision()
        self:rotateTowardsPlayer()
        self:moveTowardsPlayer(dt)
    end
end

function EnemyFollow:draw()
    self:drawImage()
end

function EnemyFollow:checkCollisionWithPlayer(player)
    if not self.dead then
        local distance = self:getDistanceToPlayer(player)
        local minDistance = self.radius + player.radius

        if distance <= minDistance then
            self.dead = true
        end

        return distance <= minDistance
    end

    return false
end

function EnemyFollow:checkAndDestroyEnemiesCollision()
    if not self.dead then
        for _, otherEnemy in ipairs(EnemyList) do
            if otherEnemy ~= self and self:checkCollisionWithEnemy(otherEnemy) then
                self:destroy()
                return
            end
        end
    end
end

function EnemyFollow:moveTowardsPlayer(dt)
    local playerX, playerY = GetPlayerPosition()
    local angle = math.atan2(playerY - self.y, playerX - self.x)
    local velX = self.speed * math.cos(angle)
    local velY = self.speed * math.sin(angle)

    self.x = self.x + velX * dt
    self.y = self.y + velY * dt
end

function EnemyFollow:rotateTowardsPlayer()
    local playerX, playerY = GetPlayerPosition()
    local angle = math.atan2(playerY - self.y, playerX - self.x)
    self.rotation = angle
end

function EnemyFollow:spawnRandomSide()
    local side = math.random(1, 4)

    if side == 1 then
        self.x = math.random(0, love.graphics.getWidth())
        self.y = -self.radius
    elseif side == 2 then
        self.x = math.random(0, love.graphics.getWidth())
        self.y = love.graphics.getHeight() + self.radius
    elseif side == 3 then
        self.x = -self.radius
        self.y = math.random(0, love.graphics.getHeight())
    else
        self.x = love.graphics.getWidth() + self.radius
        self.y = math.random(0, love.graphics.getHeight())
    end
end

function EnemyFollow:getDistanceToPlayer(player)
    return math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
end

function EnemyFollow:checkCollisionWithEnemy(otherEnemy)
    local distance = math.sqrt((otherEnemy.x - self.x) ^ 2 + (otherEnemy.y - self.y) ^ 2)
    local minDistance = otherEnemy.radius + self.radius

    return distance <= minDistance
end

function EnemyFollow:drawImage()
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function EnemyFollow:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            table.remove(EnemyList, i)
            break
        end
    end
end

return EnemyFollow
