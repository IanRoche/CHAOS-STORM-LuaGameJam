<<<<<<< Updated upstream
local Actor = Actor or require "src/Actor"
local Enemy = Enemy or require "src/Enemies/Enemy"
local Spawner = Actor:extend()
=======
local Object = Object or require "lib.classic"
local Allahakbar = Allahakbar or require "src.Enemies.AllahAkbar"
local Enemy = Enemy or require "src.Enemies.Enemy"
>>>>>>> Stashed changes

function Spawner:new(x,y,speed,fx,fy)
  Spawner.super.new(self,"src/Textures/ganivet.png",x,y,speed,fx,fy)
  self.spawnTime = 5
  self.time=0
end

function Spawner:update(dt)
  Spawner.super.update(self,dt)
  ---------------------------------------
  self.time = self.time + dt
  if self.time >self.spawnTime then
    local e = Enemy()
    self.time = 0
    table.insert(enemyList,e)
    --self.spawnTime = self.spawnTime - punts*dt*dt
    print(self.spawnTime)
  end
<<<<<<< Updated upstream
 ------------------------------------------------ SPAWN ENEMIGOS
=======
  if enemyVisibility.Enemy == true then
    if self.time > self.spawnTime then
      if self.enemySpawnTimer >= self.enemySpawnInterval then
        local eb = Enemy()
        table.insert(EnemyList, eb)
        print("new allahakbar")
        self.enemySpawnTimer = 0  -- Reiniciar el temporizador de aparición
      end
      self.time = 0
    end
  end
>>>>>>> Stashed changes
end

function Spawner:draw()
end

return Spawner