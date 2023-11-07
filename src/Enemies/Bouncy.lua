local Object = Object or require "lib.classic"
local Bouncy = Object:extend()

-- Variables de clase para la velocidad compartida y el número máximo de rebotes
Bouncy.speed = 100  -- Velocidad compartida
Bouncy.maxWallHits = 5  -- Número máximo de rebotes compartido

local allBouncysList ={}
-- Constructor
function Bouncy:new()

    local playerX, playerY = GetPlayerPosition()

    self.x = math.random(0,love.graphics.getWidth())  -- Posición X aleatoria dentro de la pantalla
    self.y = -20  -- Posición inicial justo arriba de la pantalla
    self.radius = 10
    --print(playerX, playerY)
    -- Calcula el ángulo hacia la posición actual del jugador
    local angleToPlayer = math.atan2(playerY - (-20), playerX - self.x)
    self.exploded = false  -- Bandera para rastrear si ha explotado
    self.angle = angleToPlayer  -- Ángulo hacia la posición del jugador
    self.speed = Bouncy.speed  -- Utiliza la velocidad compartida
    self.wallHits = 0  -- Contador de colisiones con las paredes
    self.maxWallHits = Bouncy.maxWallHits  -- Utiliza el número máximo de rebotes compartido
    self.aliveColor={0,0,1}
    self.deadColor={1,0,1,0}
    self.color=self.aliveColor
    
    table.insert(EnemyList, self)
    table.insert(allBouncysList, self) 
    
end

function Bouncy:update(dt)
    for _, bouncy in ipairs(allBouncysList) do
        local dx = math.cos(bouncy.angle) * bouncy.speed * dt
        local dy = math.sin(bouncy.angle) * bouncy.speed * dt

        bouncy.x = bouncy.x + dx
        bouncy.y = bouncy.y + dy

        if not bouncy.exploded then
            -- Comprueba las colisiones con las paredes
            if bouncy.x < 0 or bouncy.x > love.graphics.getWidth() then
                bouncy.angle = math.pi - bouncy.angle  -- Invierte el ángulo en caso de colisión con los bordes laterales
                bouncy.wallHits = bouncy.wallHits + 1
                -- print("Wall hit count: " .. bouncy.wallHits)
            end

            if bouncy.y < 0 then
                bouncy.y = 0
                bouncy.angle = -bouncy.angle  -- Invierte el ángulo en caso de colisión con la parte superior de la pantalla
                bouncy.wallHits = bouncy.wallHits + 1
                -- print("Wall hit count: " .. bouncy.wallHits)
            elseif bouncy.y > love.graphics.getHeight() then
                bouncy.y = love.graphics.getHeight()
                bouncy.angle = -bouncy.angle  -- Invierte el ángulo en caso de colisión con la parte inferior de la pantalla
                bouncy.wallHits = bouncy.wallHits + 1
                -- print("Wall hit count: " .. bouncy.wallHits)
            end

            -- Si ha tocado las paredes el número máximo de veces, cambia de color
            if bouncy.wallHits >= bouncy.maxWallHits then
                bouncy.color = bouncy.deadColor
                bouncy:destroy()
            end
        end
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
    love.graphics.setColor(self.color)  -- Establece el color a azul (RGB: 0, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

-- Método para destruir el enemigo
function Bouncy:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            self.exploded = true
            table.remove(EnemyList, i)
            break
        end
    end
end

return Bouncy
