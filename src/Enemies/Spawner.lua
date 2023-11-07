local Object = Object or require "lib.classic"
local Subject = require "src.Subject"  -- Ajusta la ruta de acceso al archivo Subject
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"
local Enemy = Enemy or require "src.Enemies.Enemy"
local Bouncy = Bouncy or require "src.Enemies.Bouncy"

local Spawner = Object:extend()

function Spawner:new()
    self.EnemySpawnTime = 2
    self.EnemyTime = 0
    self.EnemySpawnInterval = EnemySpawnInterval  -- Intervalo en segundos entre cada aparición de ENEMY
    self.EnemySpawnTimer = 0

    self.AllahAkbarSpawnTime = 1
    self.AllahAkbarTime = 0
    self.AllahAkbarSpawnInterval = AllahakbarSpawnInterval  -- Intervalo en segundos entre cada aparición de Allahakbar
    self.AllahAkbarSpawnTimer = 0

    self.BouncySpawnTime = 1
    self.BouncyTime = 0
    self.BouncySpawnInterval = BouncySpawnInterval  -- Intervalo en segundos entre cada aparición de BOUNCY
    self.BouncySpawnTimer = 0

    self.subject = Subject:new()
    self.subject:addObserver(self)
end

function Spawner:update(dt)
    self.EnemyTime = self.EnemyTime + dt
    self.EnemySpawnTimer = self.EnemySpawnTimer + dt

    self.AllahAkbarTime = self.AllahAkbarTime + dt
    self.AllahAkbarSpawnTimer = self.AllahAkbarSpawnTimer + dt

    self.BouncyTime = self.BouncyTime + dt
    self.BouncySpawnTimer = self.BouncySpawnTimer + dt


    --ALLAHAKBAR
    if enemyVisibility.Allahakbar == true then
        if self.AllahAkbarTime > self.AllahAkbarSpawnTime  then
            if self.AllahAkbarSpawnTimer >= self.AllahAkbarSpawnInterval then
                local e = Allahakbar()
                table.insert(EnemyList, e)
                print("in if - AllahakbarSpawnInterval: " .. self.AllahAkbarSpawnInterval)
                self.AllahAkbarSpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.AllahAkbarTime = 0
        end
    end

    --ENEMY
    if enemyVisibility.Enemy == true then
        if self.EnemyTime > self.EnemySpawnTime then
            if self.EnemySpawnTimer >= self.EnemySpawnInterval then
                local eb = Enemy()
                table.insert(EnemyList, eb)
                print("BASIC ENEMY")
                self.EnemySpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.EnemyTime = 0
        end
    end

    --BOUNCY
    if enemyVisibility.Bouncy == true then
        if self.BouncyTime > self.BouncySpawnTime then
            if self.BouncySpawnTimer >= self.BouncySpawnInterval then
                local b = Bouncy()
                table.insert(EnemyList, b)
                --print("new BOUNCY")
                self.BouncySpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.BouncyTime = 0
        end
    end
end

function Spawner:updateValue(newInterval)
    self.AllahAkbarSpawnInterval = newInterval
    print("Updated AllahakbarSpawnInterval: " .. self.AllahAkbarSpawnInterval)

    self.EnemySpawnInterval = newInterval
    print("Updated EnemySpawnInterval: " .. self.EnemySpawnInterval)

    self.BouncySpawnInterval = newInterval
    print("Updated BouncySpawnInterval: " .. self.BouncySpawnInterval)
    
    
end

function Spawner:draw()
end

return Spawner
