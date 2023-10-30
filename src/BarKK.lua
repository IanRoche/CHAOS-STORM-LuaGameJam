local Object = Object or require "lib.classic"

local Bar = Object:extend()

local m_BarTriggers = {}  -- Almacena los colliders pequeños

function Bar:new(x, y, width, height, rotationSpeed, startRotation)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.rotation = startRotation
    self.rotationSpeed = rotationSpeed
    self.rotationAngle = self.rotation * (180 / math.pi)
    
    self:createTriggers()  -- Crea los colliders pequeños
    print(self.rotation)
end

function Bar:createTriggers()
    local numTriggers = 8  -- Puedes ajustar esto según tus necesidades
    
    for i = 1, numTriggers do
        local angle = (i - 1) * (360 / numTriggers)  -- Distribuye los colliders pequeños alrededor del Bar
        local trigger = Collider.newBox(self.x, self.y, self.width, self.height, angle, 'Bar', true)
        table.insert(m_BarTriggers, trigger)
    end
end

function Bar:update(dt)
    self:rotateBar(dt)
    
    -- Actualiza la posición y el ángulo de los colliders pequeños
    for i, trigger in ipairs(m_BarTriggers) do
        trigger.x = self.x
        trigger.y = self.y
        trigger.angle = self.rotationAngle + (i - 1) * (360 / #m_BarTriggers)
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

function Bar:rotateBar(dt)
    self.rotation = self.rotation + self.rotationSpeed * dt
    self.rotationAngle = self.rotation * (180 / math.pi)  -- Actualizar el ángulo en grados
end

return Bar
