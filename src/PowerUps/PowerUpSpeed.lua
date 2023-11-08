local Object = Object or require "lib.classic"
local PowerUpSpeed = Object:extend()
local Player=require "src.Player"

function PowerUpSpeed:new()

    self.widht = 20
    self.height = 40
    
    self.x = math.random(0, love.graphics.getWidth())
    self.y = math.random(0, love.graphics.getHeight())
    
    table.insert(PowerUpsList, self)
end


function PowerUpSpeed:update(dt)
    if self:checkCollisionWithPlayer() then
        self:destroy() --si coges/colisionas el power up, este desaparece de la pantalla
    end

end

function PowerUpSpeed:draw()
  love.graphics.setColor(1, 1, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.widht, self.height)
end



function PowerUpSpeed:checkCollisionWithPlayer(player)
    if not self.dead then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        return distance <= minDistance
    end
    return false
end



function PowerUpSpeed:destroy()
    for i, powerUps in ipairs(PowerUpsList) do
        if powerUps == self then
            table.remove(PowerUpsList, i)
            break
        end
    end
end

return PowerUpSpeed