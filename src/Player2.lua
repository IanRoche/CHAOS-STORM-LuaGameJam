local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Player2 = Object:extend()

local Transform= require "lib.ColliderMaster.transform"

Player2:implement(ICanBeDestroyedInterface)

local m_Player2Trigger



function Player2:new(x, y, radius, speed, isDestroyable)
    if x and y and radius then
        self.x = x
        self.y = y
        self.radius = radius
        self.speed = speed
        self.isDestroyable = isDestroyable
        if self.isDestroyable then
            table.insert(DestroyableObjects, self)
        end
    end

        m_Player2Trigger = Collider.newCircle(self.x, self.y, self.radius, 'Player2', false)
    m_Player2Trigger.debugColor = {0, 1, 0, 1}

    m_Player2Trigger.onTriggerEnter = function(other)
        if other.tag == 'Circle' then
            Player2:destroy()
            print("Player 2 destroyed by bar")
        end
    end
end
        


function Player2:update(dt)
    self:MovePlayer(dt)
    self:CheckWindowCollisions()
    if #Collider.colliders>1 or #Collider.circleIDs>1 then
        self:updateCollider()
        
    end
    self:UpdatePlayerPosition(self.x, self.y)

    for _, enemy in ipairs(EnemyList) do
        if self:checkCollisionWithEnemy(enemy) then
            self:destroy()  -- El jugador choca con una "bolita," se activa el "Game Over"
        end
    end    
    
end

function Player2:draw()
    love.graphics.setColor(1, 0,1, 0.5)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Player2:updateCollider()
    m_Player2Trigger.x = self.x
    m_Player2Trigger.y = self.y
    m_Player2Trigger.angle =math.pi/2
end

function Player2:MovePlayer(dt)
    local l_SpeedX = 0
    local l_SpeedY = 0

    if love.keyboard.isDown("a") then
        l_SpeedX = l_SpeedX - 1
    end

    if love.keyboard.isDown("d") then
        l_SpeedX = l_SpeedX + 1
    end

    if love.keyboard.isDown("w") then
        l_SpeedY = l_SpeedY - 1
    end

    if love.keyboard.isDown("s") then
        l_SpeedY = l_SpeedY + 1
    end

    local length = math.sqrt(l_SpeedX * l_SpeedX + l_SpeedY * l_SpeedY)
    if length > 0 then
        l_SpeedX = l_SpeedX / length
        l_SpeedY = l_SpeedY / length
    end

    self.x = self.x + l_SpeedX * self.speed * dt
    self.y = self.y + l_SpeedY * self.speed * dt
end

function Player2:CheckWindowCollisions()
    local l_radius = self.radius
    local l_NewX = self.x
    local l_NewY = self.y

    if l_NewX - l_radius < 0 then
        l_NewX = l_radius
    elseif l_NewX + l_radius > love.graphics.getWidth() then
        l_NewX = love.graphics.getWidth() - l_radius
    end

    if l_NewY - l_radius < 0 then
        l_NewY = l_radius
    elseif l_NewY + l_radius > love.graphics.getHeight() then
        l_NewY = love.graphics.getHeight() - l_radius
    end

    self.x = l_NewX
    self.y = l_NewY
end

function Player2:checkCollisionWithEnemy(enemy)
    for _, e in ipairs(EnemyList) do
        if e:checkCollisionWithPlayer(self) then
            if not IsInPowerUpsList(e) then
                self:destroy()  -- El jugador choca con un enemigo que no está en PowerUpsList, se activa el "Game Over"
            end
        end
    end
end

function IsInPowerUpsList(enemy)
    for _, powerUp in ipairs(PowerUpsList) do
        if enemy == powerUp then
            return true
        end
    end
    return false
end
-- Implementar el método destroy para la clase Player
function Player2:destroy()
    -- Implementa la destrucción del jugador aquí
    self.isDestroyed = true
    -- Elimina el objeto de la lista DestroyableObjects si es destruible
    for i, obj in ipairs(DestroyableObjects) do
        if obj == self then
            table.remove(DestroyableObjects, i)
            break
        end
    end

    --print("Destroy")
    ChangeScene("GameOver")
end

function Player2:getPosition()
    return self.x, self.y
end

function Player2:UpdatePlayerPosition(x, y)
    PlayerPosition.x = x
    PlayerPosition.y = y
end

function GetPlayerPosition()
    return PlayerPosition.x, PlayerPosition.y
end

return Player2