local Object = Object or require "lib.classic"
local Enemy = Object:extend()
local Player=require "src.Player"

function Enemy:new()
    self.x = -1  -- Posición inicial x fuera de la pantalla
    self.radius = 20  -- Radio del enemigo
    self.y = love.math.random(0, love.graphics.getHeight() - self.radius * 2)  -- Posición y aleatoria
    self.speed = 100  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.dead = false  -- Bandera para rastrear si ha explotado
    
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

    if self:checkCollisionWithEnemy() then
        self:destroy()  -- Destruye el enemigo si colisiona consigo mismo
    end
end

function Enemy:draw()
  love.graphics.setColor(0, 1, 0)  -- Color rojo
  love.graphics.circle("fill", self.x, self.y, self.radius)
end



function Enemy:checkCollisionWithPlayer(player)
    if not self.dead then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        return distance <= minDistance
    end
    return false
end


function Enemy:checkCollisionWithEnemy()
    if not self.dead then
        for _, otherEnemy in ipairs(EnemyList) do
            if otherEnemy ~= self and not otherEnemy.dead then
                local distance = math.sqrt((otherEnemy.x - self.x) ^ 2 + (otherEnemy.y - self.y) ^ 2)
                local minDistance = otherEnemy.radius + self.radius
                if distance <= minDistance then
                    return true
                end
            end
        end
    end

    return false
end


function Enemy:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            table.remove(EnemyList, i)
            break
        end
    end
end

return Enemy