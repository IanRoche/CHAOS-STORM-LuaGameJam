local Object = Object or require "lib.classic"

local CircleRow = Object:extend()

local m_Circles = {}  -- Almacena los colliders para los círculos
local m_RotationIncrement = math.pi / 180  -- Incremento de rotación en radianes

function CircleRow:new(x, y, circleRadius, circleCount, rotationSpeed, circleSpacing, startRotation)
    self.x = x
    self.y = y
    self.circleRadius = circleRadius
    self.circleCount = circleCount
    self.rotationSpeed = rotationSpeed
    self.circleSpacing = circleSpacing

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
    self:rotateCircles(dt)
end

function CircleRow:draw()
    love.graphics.setColor(BarColor)  -- Color de los círculos

    for i, data in ipairs(m_Circles) do
        love.graphics.circle("fill", data.circle.x, data.circle.y, data.circle.radius)
    end

    love.graphics.setColor(1, 1, 1)  -- Restablece el color
end

function CircleRow:rotateCircles(dt)
    for i, data in ipairs(m_Circles) do
        data.angle = data.angle + CirclesRowRotationSpeed * dt
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

return CircleRow
