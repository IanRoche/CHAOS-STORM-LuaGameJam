local Object = Object or require "lib.classic"
local Enemy_AllahAkbar = Object:extend()
local Player = require "src.Player"
local SmallCircle = require "src.Enemies.SmallCircle"

local smalCircleAmount = 6

function Enemy_AllahAkbar:new()
    self.radius = 20  -- Radio del enemigo
    self.image = love.graphics.newImage("src/Textures/Enemies/Allahakbar/bomb.png")
    self.escala = self.radius * 2 / self.image:getWidth()
    self.speed = AllahAkbarVelocity  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.exploded = false  -- Bandera para rastrear si ha explotado
    self.smallCircles = {}  -- Tabla para las fracciones pequeñas

    -- Asegúrate de inicializar self.rotation en el constructor (new)
    self.rotation = 0

    -- Determina el lado de aparición aleatorio
    self:spawnRandomSide()

    table.insert(EnemyList, self)
end

function Enemy_AllahAkbar:update(dt)
    local playerX, playerY = GetPlayerPosition()

    if not self.exploded then
        -- Calcula la distancia entre el enemigo y el jugador
        local distance = math.sqrt((playerX - self.x) ^ 2 + (playerY - self.y) ^ 2)

        if distance <= 400 then
            self.timeAlive = self.timeAlive + dt

            if self.timeAlive >= 1 then
                -- Explota el enemigo
                self:explode()
            end
        end

        -- Mueve hacia el jugador
        self:rotateTowardsPlayer(playerX, playerY)
        self.x = self.x + self.speed * math.cos(self.rotation) * dt
        self.y = self.y + self.speed * math.sin(self.rotation) * dt
    else
        -- Actualiza las fracciones pequeñas
        for i, smallCircle in ipairs(self.smallCircles) do
            smallCircle:update(dt)
        end
    end
end

function Enemy_AllahAkbar:draw()
    if not self.exploded then
        -- Dibuja el enemigo
        love.graphics.draw(self.image, self.x - self.image:getWidth() * self.escala / 2,
            self.y - self.image:getHeight() * self.escala / 2, self.rotation, self.escala, self.escala)
    else
        -- Dibuja las fracciones pequeñas
        for i, smallCircle in ipairs(self.smallCircles) do
            smallCircle:draw()
        end
    end
end

function Enemy_AllahAkbar:rotateTowardsPlayer(playerX, playerY)
    self.rotation = math.atan2(playerY - self.y, playerX - self.x)
end

function Enemy_AllahAkbar:explode()
    self.exploded = true

    -- Crea fracciones pequeñas
    for i = 1, smalCircleAmount do
        local smallCircle = SmallCircle(self.x, self.y, self.radius)
        table.insert(self.smallCircles, smallCircle)
    end
end

function Enemy_AllahAkbar:checkCollisionWithPlayer(player)
    if not self.exploded then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        return distance <= minDistance
    end
    return false
end

function Enemy_AllahAkbar:spawnRandomSide()
    local side = math.random(1, 4)

    if side == 1 then
        self.x = math.random(0, love.graphics.getWidth())
        self.y = -self.radius
    elseif side == 2 then
        self.x = math.random(0, love.graphics.getWidth())
        self.y = love.graphics.getHeight() + self.radius
    elseif side == 3 then
        self.x = -self.radius
        self.y = math.random(0, love.graphics.getHeight())
    else
        self.x = love.graphics.getWidth() + self.radius
        self.y = math.random(0, love.graphics.getHeight())
    end
end

return Enemy_AllahAkbar
