local Object = Object or require "lib.classic"
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"

local Spawner = Object:extend()

function Spawner:new(x, y, speed, fx, fy)
  self.spawnTime = 1
  self.time = 0
  self.enemySpawnInterval = 1  -- Intervalo en segundos entre cada aparición de Allahakbar
  self.enemySpawnTimer = 0
end

function Spawner:update(dt)
  self.time = self.time + dt
  self.enemySpawnTimer = self.enemySpawnTimer + dt

  if enemyVisibility.Allahakbar == true then
    if self.time > self.spawnTime then
      if self.enemySpawnTimer >= self.enemySpawnInterval then
        local e = Allahakbar()
        table.insert(EnemyList, e)
        print("new allahakbar")
        self.enemySpawnTimer = 0  -- Reiniciar el temporizador de aparición
      end
      self.time = 0
    end
  end
end

function Spawner:draw()
end

return Spawner
