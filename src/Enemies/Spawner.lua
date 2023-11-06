local Object = Object or require "lib.classic"
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"
local Enemy = Enemy or require "src.Enemies.Enemy"


local Spawner = Object:extend()

function Spawner:new()
  self.spawnTime = 1
  self.time = 0
  self.enemySpawnInterval = 1  -- Intervalo en segundos entre cada aparición de Allahakbar
  self.enemySpawnTimer = 0

  self.allahakbarTimer=2
  self.allahakbarinterval=0
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
  if enemyVisibility.Enemy == true then
    if self.time > self.spawnTime then
      if self.enemySpawnTimer >= self.enemySpawnInterval then
        local eb = Enemy()
        table.insert(EnemyList, eb)
        print("new basic enemy")
        self.enemySpawnTimer = 0  -- Reiniciar el temporizador de aparición
      end
      self.time = 0
    end
  end
end

function Spawner:draw()
end

return Spawner
