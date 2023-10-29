local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Player = Object:extend()

Player:implement(ICanBeDestroyedInterface)

function Player:new(x, y, radius, speed,isDestroyable)
    self.x = x
    self.y = y
    self.radius = radius
    self.speed = speed
    self.isDestroyable=isDestroyable
    if self.isDestroyable then
        table.insert(DestroyableObjects, self)

    end
end

function Player:update(dt)
    self:MovePlayer(dt)
    self:CheckWindowCollisions()
end

function Player:draw()
    love.graphics.setColor(1, 0, 1, 1)
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
-- Implementar el método destroy para la clase Player
function Player:destroy()
    -- Implementa la destrucción del jugador aquí
    self.isDestroyed = true
    -- Elimina el objeto de la lista DestroyableObjects si es destruible
    for i, obj in ipairs(DestroyableObjects) do
        if obj == self then
            table.remove(DestroyableObjects, i)
            break
        end
    end
    ChangeScene("GameOver")
end

function Player:checkCollisionWithBar(bar)
    -- Verifica la colisión con la barra y destruye el objeto si colisiona
    local playerX, playerY = self.x, self.y
    local barX, barY = bar.x, bar.y
    local barWidth, barHeight = bar.width, bar.height

    if playerX + self.radius > barX - barWidth / 2 and
       playerX - self.radius < barX + barWidth / 2 and
       playerY + self.radius > barY - barHeight / 2 and
       playerY - self.radius < barY + barHeight / 2 then
        self:destroy()
    end
end
return Player
