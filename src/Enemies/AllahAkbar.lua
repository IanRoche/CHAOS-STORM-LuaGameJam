local Object = Object or require "lib.classic"
local Enemy_AllahAkbar = Object:extend()
local Player=require "src.Player"
local SmallCircle=require "src.Enemies.SmallCircle"




local smalCircleAmount=10

function Enemy_AllahAkbar:new()
    self.x = -1  -- Posición inicial x fuera de la pantalla
    self.y = love.math.random(0,love.graphics.getHeight())  -- Posición y aleatoria
    self.speed = 150  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.exploded = false  -- Bandera para rastrear si ha explotado
    
    self.radius = 20  -- Radio del enemigo
    self.smallCircles = {}  -- Tabla para las fracciones pequeñas
    
    
    print("new Allahakbar")

    table.insert(EnemyList, self)



end

function Enemy_AllahAkbar:update(dt)
    
    local playerX, playerY = GetPlayerPosition()  -- Obtiene la posición del jugador (ajusta esto según tu código)
    if not self.exploded then

        -- Calcula la distancia entre el enemigo y el jugador
        local distance = math.sqrt((playerX - self.x) ^ 2 + (playerY - self.y) ^ 2)

        if distance <= 200 then
            self.timeAlive = self.timeAlive + dt

            if self.timeAlive >= 1 then
                -- Explota el enemigo
                self:explode()
            else
            end
        end
        -- Mueve hacia el jugador
        local angle = math.atan2(playerY - self.y, playerX - self.x)
        self.x = self.x + self.speed * math.cos(angle) * dt
        self.y = self.y + self.speed * math.sin(angle) * dt
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
        love.graphics.setColor(1, 0, 0)  -- Color rojo
        love.graphics.circle("fill", self.x, self.y, self.radius)
    else
        -- Dibuja las fracciones pequeñas
        for i, smallCircle in ipairs(self.smallCircles) do
            smallCircle:draw()
        end
    end
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

return Enemy_AllahAkbar
