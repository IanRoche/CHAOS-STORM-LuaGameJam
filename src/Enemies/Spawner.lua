local Object = Object or require "lib.classic"
local Enemy = Enemy or require "src/Enemies/Enemy"
local Enemy_AllahAkbar = require "src.Enemies.AllahAkbar"
local Spawner =Object:extend()


function Spawner:new(x,y,speed,fx,fy)
  self.spawnTime = 1
  self.time=0
end

function Spawner:update(dt)
  ---------------------------------------
  self.time = self.time + dt
  if enemyVisibility.AllahAkbar==true then
  if self.time >self.spawnTime then
    print (enemyVisibility.Allahakbar)
      
      local e = Enemy_AllahAkbar()
      table.insert(EnemyList,e)
      print ("new allahakbar")
    end
    --self.spawnTime = self.spawnTime - punts*dt*dt
    self.time = 0

  end
 ------------------------------------------------ SPAWN ENEMIGOS
end

function Spawner:draw()
end

return Spawner