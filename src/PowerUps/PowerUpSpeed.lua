local Object = Object or require "lib.classic"
local PowerUpSpeed = Object:extend()
local Player = require "src.Player"

function PowerUpSpeed:new()
    self.width = 20
    self.height = 20
    self.x = math.random(0, love.graphics.getWidth() - self.width)
    self.y = math.random(0, love.graphics.getHeight() - self.height)
end

function PowerUpSpeed:update(dt)
    if not self.dead and self:checkCollisionWithPlayer() then
        self:applyEffect()
        self:destroy()
    end
end

function PowerUpSpeed:applyEffect()
    -- Aquí puedes implementar la lógica para aplicar el efecto del power-up al jugador
    -- Por ejemplo, aumentar temporalmente la velocidad del jugador.
end

function PowerUpSpeed:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function PowerUpSpeed:checkCollisionWithPlayer(player)
      -- Debes obtener una referencia al jugador de alguna manera
    if player then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = (player.radius + math.max(self.width, self.height)) / 2
        return distance <= minDistance
    end
    return false
end

function PowerUpSpeed:destroy()
    for i, powerUp in ipairs(PowerUpsList) do
        if powerUp == self then
            table.remove(PowerUpsList, i)
            break
        end
    end
end

return PowerUpSpeed
