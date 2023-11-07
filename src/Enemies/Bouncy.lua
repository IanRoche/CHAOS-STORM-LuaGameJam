local Object = Object or require "lib.classic"
local Bouncy = Object:extend()

-- Constructor
function Bouncy:new(playerX, playerY)

    local playerX, playerY = GetPlayerPosition()

    self.x = math.random(love.graphics.getWidth())  -- Posición X aleatoria dentro de la pantalla
    self.y = -20  -- Posición inicial justo arriba de la pantalla
    self.radius=10
    --print(playerX, playerY)
    -- Calcula el ángulo hacia la posición actual del jugador
    local angleToPlayer = math.atan2(playerY - (-20), playerX - self.x)
    self.exploded = false  -- Bandera para rastrear si ha explotado
    self.angle = angleToPlayer  -- Ángulo hacia la posición del jugador
    self.speed = 200  -- Velocidad de movimiento
    self.wallHits = 0  -- Contador de colisiones con las paredes
    -- Ajusta las coordenadas iniciales para que aparezca desde arriba de la pantalla

    table.insert(EnemyList, self)
end

function Bouncy:update(dt, playerX, playerY, playerRadius)

    local dx = math.cos(self.angle) * self.speed * dt
    local dy = math.sin(self.angle) * self.speed * dt

    self.x = self.x + dx
    self.y = self.y + dy


    -- Comprueba las colisiones con las paredes
    if self.x < 0 or self.x > love.graphics.getWidth() then
        self.angle = math.pi - self.angle  -- Invierte el ángulo en caso de colisión con los bordes laterales
        self.wallHits = self.wallHits + 1
       -- print("Wall hit count: " .. self.wallHits)
    end

    if self.y < 0 then
        self.y = 0
        self.angle = -self.angle  -- Invierte el ángulo en caso de colisión con la parte superior de la pantalla
        self.wallHits = self.wallHits + 1
       -- print("Wall hit count: " .. self.wallHits)
    elseif self.y > love.graphics.getHeight() then
        self.y = love.graphics.getHeight()
        self.angle = -self.angle  -- Invierte el ángulo en caso de colisión con la parte inferior de la pantalla
        self.wallHits = self.wallHits + 1
        --print("Wall hit count: " .. self.wallHits)
    end

    ---Si ha tocado las paredes 3 veces, destruye el enemigo
    if self.wallHits >= 3 then
        self:destroy()
    end
end


function Bouncy:checkCollisionWithPlayer(player)
    if not self.exploded then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        return distance <= minDistance
    end
    return false
end
-- Método para dibujar el enemigo
function Bouncy:draw()
    love.graphics.setColor(0, 0, 1)  -- Establece el color a azul (RGB: 0, 0, 1)
    love.graphics.circle("fill", self.x, self.y,self.radius)
    love.graphics.setColor(1, 1, 1)  -- Restaura el color predeterminado (blanco)
end

-- Método para destruir el enemigo
function Bouncy:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            table.remove(EnemyList, i)
            break
        end
    end
end

return Bouncy
