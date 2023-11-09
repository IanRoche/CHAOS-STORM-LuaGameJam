local Object = Object or require "lib.classic"
local PowerUpSpeed = Object:extend()

function PowerUpSpeed:new()
    self.width = 20
    self.height = 20
    self.exploded=false
    self.x = math.random(0, love.graphics.getWidth() - self.width)
    self.y = math.random(0, love.graphics.getHeight() - self.height)
    table.insert(PowerUpsList, self)
end

function PowerUpSpeed:update(dt)
    if  self.exploded then
        --self:applyEffect()
        self:destroy()
    end
end

function PowerUpSpeed:applyEffect()
    -- Aquí puedes implementar la lógica para aplicar el efecto del power-up al jugador
    -- Por ejemplo, aumentar temporalmente la velocidad del jugador.
    CirclesRowRotationSpeed =CirclesRowRotationSpeed-0.15
    print("Apply effect--------------")

end

function PowerUpSpeed:draw()
    local originalColor = {love.graphics.getColor()}

    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(originalColor)--es que si no ponia esto, el background cambiaba de color, igual del color que tenga la pocion....
end


function PowerUpSpeed:checkCollisionWithPlayer(player)
    local distance = math.sqrt((self.x - player.x) ^ 2 + (self.y - player.y) ^ 2)
    local minDistance = (math.max(self.width, self.height) + player.radius) / 2
    print ("me e choquiado ")
    if   distance <= minDistance then
        self.exploded=true
        
    end
    return distance <= minDistance
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
