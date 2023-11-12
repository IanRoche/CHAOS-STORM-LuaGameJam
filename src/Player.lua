local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Player = Object:extend()

Player:implement(ICanBeDestroyedInterface)

local m_PlayerTrigger

function Player:new(x, y, radius, speed, isDestroyable)
    if x and y and radius then
        self.image = love.graphics.newImage("src/Textures/player1.png")
        self.x = x
        self.y = y
        self.radius = radius
        self.speed = speed
        self.escale = 1
        self.isDestroyable = isDestroyable
        if self.isDestroyable then
            table.insert(DestroyableObjects, self)
        end

        m_PlayerTrigger = Collider.newCircle(self.x, self.y, self.radius, 'Player', false)
        m_PlayerTrigger.debugColor = {1,0,1,1}

        m_PlayerTrigger.onTriggerEnter = function(other)
            if other.tag == 'Circle' and other.isPowerUp then
                other:destroy()
            elseif other.tag == 'Circle' then
                Player:destroy()
            end
        end
    else
        print("Valores de x, y o radius no válidos")
    end
end

function Player:update(dt)
    self:movePlayer(dt)
    self:checkWindowCollisions()
    if #Collider.colliders > 1 or #Collider.circleIDs > 1 then
        self:updateCollider()
    end
    self:updatePlayerPosition(self.x, self.y)

    -- Verificar colisiones con power-ups
    for _, powerUp in ipairs(PowerUpsList) do
        if self:checkCollisionWithPowerUp(powerUp) then
            powerUp:applyEffect(self)
            powerUp:destroy()
        end
    end

    -- Verificar colisiones con enemigos
    for _, enemy in ipairs(EnemyList) do
        if self:checkCollisionWithEnemy(enemy) then
            if not isInPowerUpsList(enemy) then
                self:destroy()
            end
        end
    end
end

function Player:checkCollisionWithPowerUp(powerUp)
    local distance = math.sqrt((self.x - powerUp.x) ^ 2 + (self.y - powerUp.y) ^ 2)
    local minDistance = (math.max(self.radius, powerUp.width + 6) + powerUp.height + 6) / 2
    return distance <= minDistance
end

function Player:draw()
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.draw(self.image, self.x - self.image.getWidth(self.image) / 2, self.y - self.image.getHeight(self.image) / 2, 0, self.escale, self.escale)
end

function Player:updateCollider()
    m_PlayerTrigger.x = self.x
    m_PlayerTrigger.y = self.y
    m_PlayerTrigger.angle = math.pi / 2
end

function Player:movePlayer(dt)
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

    self.x = self.x + l_SpeedX * PlayerSpeed * dt
    self.y = self.y + l_SpeedY * PlayerSpeed * dt
end

function Player:checkWindowCollisions()
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

function Player:checkCollisionWithEnemy(enemy)
    for _, e in ipairs(EnemyList) do
        if e:checkCollisionWithPlayer(self) then
            if not isInPowerUpsList(e) then
                self:destroy()
            end
        end
    end
end

function isInPowerUpsList(enemy)
    for _, powerUp in ipairs(PowerUpsList) do
        if enemy == powerUp then
            return true
        end
    end
    return false
end

function Player:destroy()
    self.isDestroyed = true
    for i, obj in ipairs(DestroyableObjects) do
        if obj == self then
            table.remove(DestroyableObjects, i)
            break
        end
    end
    ChangeScene("GameOver")
end

function Player:getPosition()
    return self.x, self.y
end

function Player:updatePlayerPosition(x, y)
    PlayerPosition.x = x
    PlayerPosition.y = y
end

function GetPlayerPosition()
    return PlayerPosition.x, PlayerPosition.y
end

return Player
