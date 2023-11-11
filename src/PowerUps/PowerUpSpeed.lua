local Object = Object or require "lib.classic"
local PowerUpSpeed = Object:extend()


function PowerUpSpeed:new()
    self.width = 70
    self.height = 70
    self.exploded=false
    self.x = math.random(0, love.graphics.getWidth() - self.width)
    self.y = math.random(0, love.graphics.getHeight() - self.height)
    self.image = love.graphics.newImage("src/Textures/reloj.png")
    self.escalaX = self.width / self.image:getWidth()
    self.escalaY = self.height / self.image:getHeight()
    table.insert(PowerUpsList, self)
end

function PowerUpSpeed:update(dt)
    if  self.exploded then
        self:applyEffect()
        self:destroy()
    end
end

function PowerUpSpeed:applyEffect()
    -- Aquí puedes implementar la lógica para aplicar el efecto del power-up al jugador
    -- Por ejemplo, aumentar temporalmente la velocidad del jugador.
    print("Apply effect--------------")
    CirclesRowRotationSpeed = CirclesRowRotationSpeed - 0.25

end

function PowerUpSpeed:draw()
    local originalColor = {love.graphics.getColor()}  -- Guarda el color actual

    -- círculo detrás de la imagen
    love.graphics.setColor(1, 1, 0, 0.3)  -- Amarillo  medio transparente
    love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.width / 2)

    -- imagen sobre el círculo con transparencia
    love.graphics.setColor(1, 1, 1, 0.7)  
    love.graphics.draw(self.image, self.x, self.y, 0, self.escalaX, self.escalaY)

    love.graphics.setColor(originalColor)  -- Restaura el color original
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
