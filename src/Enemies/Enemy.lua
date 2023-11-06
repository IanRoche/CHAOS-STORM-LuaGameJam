local Object = Object or require "lib/classic"
local Player = Player or require "src/Player"
local Actor = Actor or require "src/Actor"
local Spawner = require "src/Enemies/Spawner"

local Enemy = Object:extend()

enemyList = {}

function Enemy:new()
<<<<<<< Updated upstream
    local s = Spawner()
    table.insert(enemyList,s)
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
         local distance = v.position - self.position
         if distance < 16 then--16 pq es el tamaño de la textura
            Player:destroy()
            print("destroyed by enemy")
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
  
=======

    self.x = -1  -- Posición inicial x fuera de la pantalla
    self.y = love.math.random(0,love.graphics.getHeight())  -- Posición y aleatoria
    self.speed = 250  -- Velocidad de movimiento
    self.timeAlive = 0  -- Tiempo que el enemigo ha estado cerca del jugador
    self.exploded = false  -- Bandera para rastrear si ha explotado
    self.radius = 20  -- Radio del enemigo
    
    print("new basic enemy")

    table.insert(EnemyList, self)
  end
  
  function Enemy:update(dt)
    local playerX, playerY = GetPlayerPosition()  -- Obtiene la posición del jugador
    -- Mueve hacia el jugador
    local angle = math.atan2(playerY - self.y, playerX - self.x)
    self.x = self.x + self.speed * math.cos(angle) * dt
    self.y = self.y + self.speed * math.sin(angle) * dt
>>>>>>> Stashed changes
  end
  
  function Enemy:draw()
    love.graphics.setColor(0, 1, 0)  -- Color verde
    love.graphics.circle("fill", self.x, self.y, self.radius)
  end

  return Enemy