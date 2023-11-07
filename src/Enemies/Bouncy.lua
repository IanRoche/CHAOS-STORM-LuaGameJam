local Object = Object or require "lib.classic"
local Bouncy = Object:extend()

-- Variables de clase para la velocidad compartida y el número máximo de rebotes
Bouncy.speed = 100  -- Velocidad compartida
Bouncy.maxWallHits = 4  -- Número máximo de rebotes compartido

local allBouncysList ={}
-- Constructor
function Bouncy:new()
    local playerX, playerY = GetPlayerPosition()

    local side = math.random(1, 4)  -- Genera un número aleatorio para determinar el lado de aparición

    if side == 1 then
        -- Aparecer arriba de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = -20
        self.angle = math.random(0, math.pi)  -- Ángulo aleatorio apuntando hacia abajo
    elseif side == 2 then
        -- Aparecer abajo de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = love.graphics.getHeight() + 20
        self.angle = math.random(0, math.pi)  -- Ángulo aleatorio apuntando hacia arriba
    elseif side == 3 then
        -- Aparecer a la izquierda de la pantalla
        self.x = -20
        self.y = math.random(0, love.graphics.getHeight())
        self.angle = math.random(-math.pi / 2, math.pi / 2)  -- Ángulo aleatorio apuntando hacia la derecha
    else
        -- Aparecer a la derecha de la pantalla
        self.x = love.graphics.getWidth() + 20
        self.y = math.random(0, love.graphics.getHeight())
        self.angle = math.random(-math.pi / 2, math.pi / 2)  -- Ángulo aleatorio apuntando hacia la izquierda
    end

    self.radius = 10
    self.exploded = false
    self.speed = Bouncy.speed
    self.wallHits = 0
    self.maxWallHits = Bouncy.maxWallHits
    self.aliveColor = {0, 0, 1}
    self.deadColor = {1, 0, 1, 1}
    self.color = self.aliveColor

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
