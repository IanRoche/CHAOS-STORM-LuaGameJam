local Object = Object or require "lib.classic"

local CircleRow = Object:extend()

local m_Circles = {}  -- Almacena los colliders para los círculos
local m_RotationIncrement = math.pi / 180  -- Incremento de rotación en radianes
local angle = 0--angulo de rotación del sprite de cada círculo

function CircleRow:new(x, y, circleRadius, circleCount, rotationSpeed, circleSpacing, startRotation)
    self.x = x
    self.y = y
    self.circleRadius = circleRadius
    self.circleCount = circleCount
    self.rotationSpeed = CirclesRowRotationSpeed
    self.circleSpacing = circleSpacing
    self.image = love.graphics.newImage("src/Textures/Enemies/shuriken.png")
    self.escala = self.circleRadius * 4  / self.image:getWidth()
    
    



    -- Verifica si ya existen círculos creados
    if #m_Circles == 0 then
        self:createCircles(startRotation)
    else
        
        self:updateCircles()
    end
end

function CircleRow:createCircles(startRotation)
    for i = 1, self.circleCount do
        local angle = (i - 1) * m_RotationIncrement + startRotation  -- Distribuye los círculos en una hélice y aplica el ángulo de inicio
        local radiusIncrement = self.circleSpacing * i  -- Controla la distancia entre los círculos
        local circleX = self.x + radiusIncrement * math.cos(angle)
        local circleY = self.y + radiusIncrement * math.sin(angle)
        local circle = self:createCircle(circleX, circleY)
        table.insert(m_Circles, { circle = circle, angle = angle })
    end
end

function CircleRow:createCircle(x, y)
    return Collider.newCircle(x, y, self.circleRadius, 'Circle', true)
end

function CircleRow:updateCircles()
    for i, data in ipairs(m_Circles) do
        local radiusIncrement = self.circleSpacing * i
        data.circle.x = self.x + radiusIncrement * math.cos(data.angle)
        data.circle.y = self.y + radiusIncrement * math.sin(data.angle)
    end
end

function CircleRow:update(dt)
    self:modifyVariableBasedOnSine(dt, CirclesRowMinCirclesSpacing, CirclesRowMaxCircleSpacing,CirclesRowChangeFrequency,CirclesRowChangeSpeed)  -- Ejemplo con amplitud 10 y frecuencia 2
    self:rotateCircles(dt)
    angle = angle +2 *math.pi *dt -- rotación individual de cada cículo
    
end

function CircleRow:draw()
    love.graphics.setColor(BarColor)  -- Color de los círculos

    for i, data in ipairs(m_Circles) do
        love.graphics.draw(self.image, data.circle.x, data.circle.y, angle, self.escala, 
        self.escala, self.image:getWidth() / 2, self.image:getHeight() / 2)--el sprite rota desde su centro
    end

    love.graphics.setColor(1, 1, 1)  -- Restablece el color
    
end

function CircleRow:rotateCircles(dt)
    for i, data in ipairs(m_Circles) do
        data.angle = data.angle + CirclesRowRotationSpeed * dt--rotación general
        local radiusIncrement = self.circleSpacing * i
        data.circle.x = self.x + radiusIncrement * math.cos(data.angle)
        data.circle.y = self.y + radiusIncrement * math.sin(data.angle)
    end
end

function CircleRow:clearColliders()
    for i, data in ipairs(m_Circles) do
        Collider.remove(data.circle)
    end
    m_Circles = {}
end

function CircleRow:modifyVariableBasedOnSine(dt, minCircleSpacing, maxCircleSpacing, changeFrequency, changeSpeed)
    local time = love.timer.getTime()
    local sineValue = math.sin(changeFrequency * time * changeSpeed)

    -- Normalizamos el valor del seno al rango [0, 1] y luego lo escalamos al rango [minCircleSpacing, maxCircleSpacing]
    self.circleSpacing = minCircleSpacing + (1 + sineValue) * 0.5 * (maxCircleSpacing - minCircleSpacing)

    -- Aseguramos que 'circleSpacing' esté en el rango [minCircleSpacing, maxCircleSpacing]
    self.circleSpacing = math.min(maxCircleSpacing, math.max(minCircleSpacing, self.circleSpacing))
end


return CircleRow
