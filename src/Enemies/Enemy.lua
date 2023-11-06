local Object = Object or require "lib/classic"
local Player = Player or require "src/Player"
local Actor = Actor or require "src/Actor"
--local Spawner = require "src/Enemies/Spawner"

local Enemy = Object:extend()


function Enemy:new()
   -- local s = Spawner()
    table.insert(EnemyList,s)
    self.speed = 8
  end
  
  function Enemy:update(dt)


    Enemy.super.update(self,dt)
    ----------------------------------------------ENEMIGOS SIGUEN PLAYER
    for k,v in ipairs (EnemyList) do
  
       if v:is(Player) then--cuando un enemigo le da al player
         local pPos = v.position
         self.forward = pPos- self.position
         self.forward:normalize()
         local distance = v.position - self.position
         if distance < 16 then--16 pq es el tamaño de la textura
            Player:destroy()
            print("destroyed by enemy")
           local e=nil
           for k,v in ipairs(EnemyList) do
             if v == self then
               e=k
             end
           end
           table.remove(EnemyList,e) --desaparece enemigo
         end
   
       end
     end
  
  end
  
  function Enemy:draw()
    local xx = self.position.x
    local ox = self.origin.x
    local yy = self.position.y
    local oy = self.origin.y
    local sx = self.scale.x
    local sy = self.scale.y
    local rr = self.rot
    love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
  end

  return Enemy