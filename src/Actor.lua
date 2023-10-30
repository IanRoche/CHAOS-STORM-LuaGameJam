local Object = Object or require "lib/object"
local EnemyList = Object:extend()


function EnemyList:new(image,x,y,speed,fx,fy)
    self.speed = speed or 30
    self.rot = 0
    self.height = self.image:getHeight()
    self.width  = self.image:getWidth()
end

function EnemyList:update(dt)
    self.position = self.position + self.forward * self.speed * dt
end

function EnemyList:draw()
end

return EnemyList