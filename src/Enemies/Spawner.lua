local Actor = Actor or require "src/Actor"
local Enemy = Enemy or require "src/Enemies/Enemy"
local Spawner = Actor:extend()

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
 ------------------------------------------------ SPAWN ENEMIGOS
end

function Spawner:draw()
end

return Spawner