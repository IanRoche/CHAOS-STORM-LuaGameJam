local Object = Object or require "lib.classic"
local EnemyFollow = Object:extend()
local Player=require "src.Player"

function EnemyFollow:new()

    self.image = love.graphics.newImage("src/Textures/green_fireball.png")
    self.radius = 25  -- Radio del enemigo
    self.escala = self.radius * 2  / self.image:getWidth()
    self.speed = EnemyFollowVelocity  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.dead = false  -- Bandera para rastrear si ha explotado
    
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

    print(self.x, self.y)
    table.insert(EnemyList, self)
end

function EnemyFollow:update(dt)
    if not self.dead then
        if self:checkCollisionWithEnemies() then
            self:destroy()  -- Enemy se destruye al tocar otro enemigo de la lista EnemyList
        end
        local playerX, playerY = GetPlayerPosition()  -- Obtiene la posición actual del jugador (ajusta esto según tu código)
        -- Calcula el ángulo hacia el jugador
        local angle = math.atan2(playerY - self.y, playerX - self.x)
        -- Calcula las componentes de velocidad en X e Y basadas en el ángulo
        local velX = self.speed * math.cos(angle)
        local velY = self.speed * math.sin(angle)

        -- Mueve al enemigo hacia el jugador
        self.x = self.x + velX * dt
        self.y = self.y + velY * dt
    end

end

function EnemyFollow:draw()
  --love.graphics.setColor(0, 1, 0)  -- Color rojo (esto sin comentar estaba cambiando el color del background a verde fosforito)
  --love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.draw(self.image, self.x - self.image:getWidth() * self.escala / 2, 
  self.y - self.image:getHeight() * self.escala / 2, 0, self.escala, self.escala)
end



function EnemyFollow:checkCollisionWithPlayer(player)
    if not self.dead then
        local distance = math.sqrt((player.x - self.x) ^ 2 + (player.y - self.y) ^ 2)
        local minDistance = player.radius + self.radius
        if   distance <= minDistance then
            self.dead = true
        end
        return distance <= minDistance
    end
    return false
end


function EnemyFollow:checkCollisionWithEnemies()
    if not self.dead then
        for _, otherEnemy in ipairs(EnemyList) do
            if otherEnemy ~= self then
                --print("Warning: Enemy")
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

function EnemyFollow:destroy()
    for i, enemy in ipairs(EnemyList) do
        if enemy == self then
            table.remove(EnemyList, i)
            break
        end
    end
end

return EnemyFollow