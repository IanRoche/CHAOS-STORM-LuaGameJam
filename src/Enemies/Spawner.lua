local Object = Object or require "lib.classic"
local Subject = require "src.Subject"
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"
local EnemyFollow = EnemyFollow or require "src.Enemies.EnemyFollow"
local Bouncy = Bouncy or require "src.Enemies.Bouncy"

local Spawner = Object:extend()

function Spawner:new()
    self.m_EnemySpawnTime = 2
    self.m_EnemyTime = 0
    self.m_EnemySpawnInterval = EnemySpawnInterval
    self.m_EnemySpawnTimer = 0

    self.AllahAkbarSpawnTime = 1
    self.AllahAkbarTime = 0
    self.AllahAkbarSpawnInterval = AllahAkbarSpawnInterval
    self.AllahAkbarSpawnTimer = 0

    self.BouncySpawnTime = 1
    self.BouncyTime = 0
    self.BouncySpawnInterval = BouncySpawnInterval
    self.BouncySpawnTimer = 0

    self.subject = Subject:new()
    self.subject:addObserver(self)
end

function Spawner:update(dt)

    --actualizar tiempo
    self.m_EnemyTime = self.m_EnemyTime + dt
    self.m_EnemySpawnTimer = self.m_EnemySpawnTimer + dt

    self.AllahAkbarTime = self.AllahAkbarTime + dt
    self.AllahAkbarSpawnTimer = self.AllahAkbarSpawnTimer + dt

    self.BouncyTime = self.BouncyTime + dt
    self.BouncySpawnTimer = self.BouncySpawnTimer + dt


    --ALLAHAKBAR
    if enemyVisibility.Allahakbar == true then
        if self.AllahAkbarTime > self.AllahAkbarSpawnTime  then
            if self.AllahAkbarSpawnTimer >= AllahAkbarSpawnInterval then
                local e = Allahakbar()
                table.insert(EnemyList, e)
                self.AllahAkbarSpawnTimer = 0
            end
            self.AllahAkbarTime = 0
        end
    end

    --ENEMY
    if enemyVisibility.EnemyFollow == true then
        if self.m_EnemyTime > self.m_EnemySpawnTime then
            if self.m_EnemySpawnTimer >= EnemySpawnInterval then
                local ef = EnemyFollow()
                table.insert(EnemyList, ef)
                self.m_EnemySpawnTimer = 0
            end
            self.m_EnemyTime = 0
        end
    end

    --BOUNCY
    if enemyVisibility.Bouncy == true then
        if self.BouncyTime > self.BouncySpawnTime then
            if self.BouncySpawnTimer >= BouncySpawnInterval then
                local b = Bouncy()
                table.insert(EnemyList, b)
                self.BouncySpawnTimer = 0
            end
            self.BouncyTime = 0
        end
    end
end


function Spawner:updateValue(newInterval)
    self.AllahAkbarSpawnInterval = newInterval

    self.m_EnemySpawnInterval = newInterval

    self.BouncySpawnInterval = newInterval
end

function Spawner:draw()
end

return Spawner
