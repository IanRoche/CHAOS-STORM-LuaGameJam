local Object = Object or require "lib.classic"
local Enemy_AllahAkbar = Object:extend()
local Player=require "src.Player"
local SmallCircle=require "src.Enemies.SmallCircle"




local smalCircleAmount=6

function Enemy_AllahAkbar:new()
    
    self.radius = 20  -- Radio del enemigo

    self.image = love.graphics.newImage("src/Textures/bomb.png")
    self.escala = self.radius * 2  / self.image:getWidth()

    self.speed = AllahAkbarVelocity  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.exploded = false  -- Bandera para rastrear si ha explotado
    self.smallCircles = {}  -- Tabla para las fracciones pequeñas
    
    local side = math.random(1, 4)  -- Genera un número aleatorio para determinar el lado de aparición

    if side == 1 then
        -- Aparecer arriba de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = -self.radius
    elseif side == 2 then
        -- Aparecer abajo de la pantalla
        self.x = math.random(0, love.graphics.getWidth())
        self.y = love.graphics.getHeight() + self.radius
    elseif side == 3 then
        -- Aparecer a la izquierda de la pantalla
        self.x = -self.radius
        self.y = math.random(0, love.graphics.getHeight())
    else
        -- Aparecer a la derecha de la pantalla
        self.x = love.graphics.getWidth() + self.radius
        self.y = math.random(0, love.graphics.getHeight())
    end
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
            else
            end
        end
        -- Mueve hacia el jugador
        local angle = math.atan2(playerY - self.y, playerX - self.x)
        self.x = self.x + AllahAkbarVelocity * math.cos(angle) * dt
        self.y = self.y + AllahAkbarVelocity * math.sin(angle) * dt
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
        --love.graphics.setColor(1, 0, 0)  -- Color rojo
        love.graphics.draw(self.image, self.x - self.image:getWidth() * self.escala / 2, 
        self.y - self.image:getHeight() * self.escala / 2, 0, self.escala, self.escala)
        --love.graphics.circle("fill", self.x, self.y, self.radius)
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
