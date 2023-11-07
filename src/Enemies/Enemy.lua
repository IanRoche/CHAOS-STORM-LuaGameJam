local Object = Object or require "lib.classic"
local Enemy = Object:extend()
local Player=require "src.Player"

function Enemy:new()
    self.x = -1  -- Posición inicial x fuera de la pantalla
    self.y = love.math.random(0,love.graphics.getHeight())  -- Posición y aleatoria
    self.speed = 100  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.exploded = false  -- Bandera para rastrear si ha explotado
    
    self.radius = 20  -- Radio del enemigo
    table.insert(EnemyList, self)

end

function Enemy:update(dt)
    
    local playerX, playerY = GetPlayerPosition()  -- Obtiene la posición del jugador (ajusta esto según tu código)
    if not self.exploded then
        -- Calcula la distancia entre el enemigo y el jugador
        local distance = math.sqrt((playerX - self.x) ^ 2 + (playerY - self.y) ^ 2)

        
        -- Mueve hacia el jugador
        local angle = math.atan2(playerY - self.y, playerX - self.x)
        self.x = self.x + self.speed * math.cos(angle) * dt
        self.y = self.y + self.speed * math.sin(angle) * dt
    end
end

function Enemy:draw()
  love.graphics.setColor(0, 1, 0)  -- Color rojo
  love.graphics.circle("fill", self.x, self.y, self.radius)
end



function Enemy:checkCollisionWithPlayer(player)
    if not self.exploded then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        return distance <= minDistance
    end
    return false
end

return Enemy