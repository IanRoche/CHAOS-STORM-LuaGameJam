local Object = Object or require "lib.classic"

local SmallCircle = Object:extend()

function SmallCircle:new(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius / 3  -- Tamaño más pequeño que el del enemigo original
    self.speed = 20  -- Velocidad de movimiento de las fracciones
    self.angle = love.math.random() * (2 * math.pi)  -- Ángulo de movimiento aleatorio
    table.insert(EnemyList,self)
end

function SmallCircle:update(dt)
    -- Mueve las fracciones en la dirección del ángulo
    self.x = self.x + self.speed * math.cos(self.angle) * dt
    self.y = self.y + self.speed * math.sin(self.angle) * dt
end

function SmallCircle:draw()
    -- Dibuja las fracciones pequeñas
    love.graphics.setColor(1, 0, 0)  -- Color rojo (ajusta el color según tus preferencias)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function SmallCircle:checkCollisionWithPlayer(player)
    local distance = math.sqrt((self.x - player.x) ^ 2 + (self.y - player.y) ^ 2)
    local minDistance = self.radius + player.radius
    return distance <= minDistance
end

return SmallCircle
