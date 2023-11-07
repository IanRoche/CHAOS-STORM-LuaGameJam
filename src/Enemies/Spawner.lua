local Object = Object or require "lib.classic"
local Subject = require "src.Subject"  -- Ajusta la ruta de acceso al archivo Subject
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"
local Enemy = Enemy or require "src.Enemies.Enemy"

local Spawner = Object:extend()

function Spawner:new()
    self.spawnTime = 3
    self.time = 0
    self.enemySpawnInterval = EnemySpawnInterval  -- Intervalo en segundos entre cada aparición de Allahakbar
    self.enemySpawnTimer = 0

    self.AllahAkbarSpawnTime = 1
    self.AllahAkbarTime = 0
    self.AllahAkbarSpawnInterval = AllahakbarSpawnInterval  -- Intervalo en segundos entre cada aparición de Allahakbar
    self.AllahAkbarSpawnTimer = 0

    self.subject = Subject:new()
    self.subject:addObserver(self)
end

function Spawner:update(dt)
    self.time = self.time + dt
    self.enemySpawnTimer = self.enemySpawnTimer + dt
    self.AllahAkbarTime = self.AllahAkbarTime + dt
    self.AllahAkbarSpawnTimer = self.AllahAkbarSpawnTimer + dt

    if enemyVisibility.Allahakbar == true then
        if self.AllahAkbarTime > self.AllahAkbarSpawnTime  then
            if self.AllahAkbarSpawnTimer >= self.AllahAkbarSpawnInterval then
                local e = Allahakbar()
                table.insert(EnemyList, e)
                print("in if - AllahakbarSpawnInterval: " .. self.AllahAkbarSpawnInterval)
                self.AllahAkbarSpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.time = 0
        end
    end
    if enemyVisibility.Enemy == true then
        if self.time > self.spawnTime then
            if self.enemySpawnTimer >= self.enemySpawnInterval then
                local eb = Enemy()
                table.insert(EnemyList, eb)
                --print("new basic enemy")
                self.enemySpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.time = 0
        end
    end
end

function Spawner:updateValue(newInterval)
    self.AllahAkbarSpawnInterval = newInterval
    print("Updated AllahakbarSpawnInterval: " .. self.AllahAkbarSpawnInterval)
end

function Spawner:draw()
end

return Spawner
