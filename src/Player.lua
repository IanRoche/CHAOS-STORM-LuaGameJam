local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Player = Object:extend()

local Transform= require "lib.ColliderMaster.transform"

Player:implement(ICanBeDestroyedInterface)

local m_PlayerTrigger



function Player:new(x, y, radius, speed, isDestroyable)
    if x and y and radius then
        self.x = x
        self.y = y
        self.radius = radius
        self.speed = speed
        self.isDestroyable = isDestroyable
        if self.isDestroyable then
            table.insert(DestroyableObjects, self)
        end

        m_PlayerTrigger = Collider.newCircle(self.x, self.y, self.radius, 'Player', false)
        m_PlayerTrigger.debugColor = {1,0,1,1}

        -- Define la función onTriggerEnter para el objeto m_PlayerTrigger
        m_PlayerTrigger.onTriggerEnter = function(other)
            if other.tag == 'Circle' then
                Player:destroy()
                print("destroyed by bar")

            end
        end
    else
        print("Valores de x, y o radius no válidos")
    end
end


function Player:update(dt)
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

function Player:draw()
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Player:updateCollider()
     m_PlayerTrigger.x = self.x
     m_PlayerTrigger.y = self.y
     m_PlayerTrigger.angle =math.pi/2
end

function Player:MovePlayer(dt)
    local l_SpeedX = 0
    local l_SpeedY = 0

    if love.keyboard.isDown("left") then
        l_SpeedX = l_SpeedX - 1
    end

    if love.keyboard.isDown("right") then
        l_SpeedX = l_SpeedX + 1
    end

    if love.keyboard.isDown("up") then
        l_SpeedY = l_SpeedY - 1
    end

    if love.keyboard.isDown("down") then
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

function Player:CheckWindowCollisions()
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

function Player:checkCollisionWithEnemy(enemy)--Esto hace que el player muera si entra en contacto con allahAkbar PERO hay un problema,
    for _, enemy in ipairs(EnemyList) do
        if enemy:checkCollisionWithPlayer(self) then
            self:destroy()  -- El jugador choca con un "Allahakbar", se activa el "Game Over"
        end
    end
end

-- Implementar el método destroy para la clase Player
function Player:destroy()
    -- Implementa la destrucción del jugador aquí
    self.isDestroyed = true
    -- Elimina el objeto de la lista DestroyableObjects si es destruible
    for i, obj in ipairs(DestroyableObjects) do
        if obj == self then
            table.remove(DestroyableObjects, i)
            break
        end
    end

    print("Destroy")
    ChangeScene("GameOver")
end

function Player:getPosition()
    return self.x, self.y
end

function Player:UpdatePlayerPosition(x, y)
    PlayerPosition.x = x
    PlayerPosition.y = y
end

function GetPlayerPosition()
    return PlayerPosition.x, PlayerPosition.y
end

return Player
