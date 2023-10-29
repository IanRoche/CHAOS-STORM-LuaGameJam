local Object = Object or require "lib.classic"

local Bar = Object:extend()

function Bar:new(x, y, width, height, rotationSpeed,startRotation)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.rotation = startRotation
    self.rotationSpeed = rotationSpeed
end

function Bar:update(dt, objects)
    self.rotation = self.rotation + self.rotationSpeed * dt
    for _, obj in ipairs(objects) do
        obj:checkCollisionWithBar(self)
    end
end

function Bar:draw()
    love.graphics.push()  -- Guardar la matriz de transformación actual
    love.graphics.translate(self.x + self.width / 2, self.y + self.height / 2)  -- Centrar la barra
    love.graphics.rotate(self.rotation)  -- Aplicar la rotación
    love.graphics.setColor(BarColor)
    love.graphics.rectangle("fill", -self.width / 2, -self.height / 2, self.width, self.height)  -- Dibujar la barra centrada
    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()  -- Restaurar la matriz de transformación
end


return Bar
