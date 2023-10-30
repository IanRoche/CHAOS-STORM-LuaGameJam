local Object = Object or require "lib.classic"
local Enemy = Object:extend()
local Player = Object:extend()
local enemyList = Object:extend()


function Enemy:new()

    self.speed = 8
  end
  
  function Enemy:update(dt)


    Enemy.super.update(self,dt)
    ----------------------------------------------ENEMIGOS SIGUEN PLAYER
    for k,v in ipairs (enemyList) do
  
       if v:is(Player) then--cuando un enemigo le da al player
         local pPos = v.position
         self.forward = pPos- self.position
         self.forward:normalize()
         local dist = v.position - self.position
         if dist:len() < 16 then--16 pq es el tamaño de la textura
           vida = vida-1 --baja una vida
           punts = punts -5 --bajan puntos
           local e=nil
           for k,v in ipairs(enemyList) do
             if v == self then
               e=k
             end
           end
           table.remove(enemyList,e) --desaparece enemigo
         end
   
       end
     end
  ---------------------------------------------------
  
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