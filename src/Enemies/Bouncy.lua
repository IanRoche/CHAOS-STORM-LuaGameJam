local Object = Object or require "lib.classic"
local Bouncy = Object:extend()

-- Variables de clase para la velocidad compartida y el número máximo de rebotes
Bouncy.speed = BouncyVelocity  -- Velocidad compartida
Bouncy.maxWallHits = BouncyMaxWallHits  -- Número máximo de rebotes compartido

local allBouncysList = {}

-- Constructor
function Bouncy:new()
    local playerX, playerY = GetPlayerPosition()

    local side = math.random(1, 4)  -- Genera un número aleatorio para determinar el lado de aparición

    if side == 1 then
        -- Aparecer arriba de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = -20
    elseif side == 2 then
        -- Aparecer abajo de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = love.graphics.getHeight() + 20
    elseif side == 3 then
        -- Aparecer a la izquierda de la pantalla
        self.x = -20
        self.y = math.random(0, love.graphics.getHeight())
    else
        -- Aparecer a la derecha de la pantalla
        self.x = love.graphics.getWidth() + 20
        self.y = math.random(0, love.graphics.getHeight())
    end

    self.angle = math.atan2(playerY - self.y, playerX - self.x)  -- Ángulo hacia el jugador
    self.image = love.graphics.newImage("src/Textures/bouncy2.png")
    self.radius = 10
    self.escala = self.radius * 2  / self.image:getWidth()
    self.exploded = false
    self.speed = BouncyVelocity
    self.wallHits = 0
    self.aliveColor = {0, 0, 1}
    self.deadColor = {1, 0, 1, 0}
    self.color = self.aliveColor

    table.insert(EnemyList, self)
    table.insert(allBouncysList, self)
end

function Bouncy:update(dt)
    for _, bouncy in ipairs(allBouncysList) do
        local dx = math.cos(bouncy.angle) * BouncyVelocity * dt
        local dy = math.sin(bouncy.angle) * BouncyVelocity * dt

        bouncy.x = bouncy.x + dx
        bouncy.y = bouncy.y + dy

        if not bouncy.exploded then
            -- Comprueba las colisiones con las paredes
            bouncy:checkWallCollisions()

            -- Si ha tocado las paredes el número máximo de veces, cambia de color
            if bouncy.wallHits >= BouncyMaxWallHits then
                bouncy.color = bouncy.deadColor
                bouncy:destroy()
            end
        end
    end
end

function Bouncy:checkWallCollisions()
    if self.x < 0 or self.x > love.graphics.getWidth() then
        self.angle = math.pi - self.angle  -- Invierte el ángulo en caso de colisión con los bordes laterales
        self.wallHits = self.wallHits + 1
    end

    if self.y < 0 then
        self.y = 0
        self.angle = -self.angle  -- Invierte el ángulo en caso de colisión con la parte superior de la pantalla
        self.wallHits = self.wallHits + 1
    elseif self.y > love.graphics.getHeight() then
        self.y = love.graphics.getHeight()
        self.angle = -self.angle  -- Invierte el ángulo en caso de colisión con la parte inferior de la pantalla
        self.wallHits = self.wallHits + 1
    end
end

function Bouncy:checkCollisionWithPlayer(player)
    if not self.exploded then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        if distance <= minDistance then
            self.exploded = true
        end
        return distance <= minDistance
    end
    return false
end

-- Método para dibujar el enemigo
function Bouncy:draw()
    love.graphics.draw(self.image, self.x - self.image:getWidth() * self.escala / 2, 
    self.y - self.image:getHeight() * self.escala / 2, 0, self.escala, self.escala)
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
