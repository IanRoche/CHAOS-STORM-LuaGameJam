local Object = Object or require "lib.classic"
local Score = Object:extend()

function Score:new()
    self.score = 0  -- Inicializa la puntuación a cero
    self.font = love.graphics.newFont(24)  -- Fuente para la puntuación
    self.timeElapsed = 0  -- Lleva un seguimiento del tiempo transcurrido
    self.pointsPerSecond = 1  -- Puntos por segundo
end

function Score:update(dt)
    self.timeElapsed = self.timeElapsed + dt  -- Actualiza el tiempo transcurrido

    -- Verifica si ha transcurrido al menos 1 segundo
    if self.timeElapsed >= 1 then
        self:increaseScore(self.pointsPerSecond)  -- Aumenta la puntuación
        self.timeElapsed = self.timeElapsed - 1  -- Reinicia el tiempo transcurrido
    end
end

function Score:increaseScore(points)
    self.score = self.score + points
end

function Score:draw()
    -- Establece la fuente para la puntuación
    love.graphics.setFont(self.font)

    -- Dibuja la puntuación en la esquina superior izquierda
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Puntuación: " .. self.score, 10, 10)
end

return Score
