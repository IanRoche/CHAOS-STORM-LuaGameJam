local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Enemy=require "src.Enemies.Enemy"
local Player =Player or require "src.Player"
local Score = require "src.Score"  
local CirclesRow=CirclesRow or  require "src.CirclesRow"

local m_Enemy = Enemy
local m_Player
local m_Score
local currentDifficultyLevel = 1  -- Nivel de dificultad actual
local m_CirclesRow

function Scene:new()
    if #Collider.colliders>1 then
        
        Collider:clearAllColliders()
    end
    print("Game")
    --m_Bar = Bar(BarStartPosX, BarStartPosY, BarWidth, BarHeight, BarRotSpeed, BarStartRotation)  -- Crea una instancia de la barra
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed,true)
    m_Score = Score() 
    _Score=0
    m_CirclesRow=CirclesRow(MapCenterX,MapCenterY,10,15,1,40,math.pi)
    m_Enemy:new()
end

function Scene:update(dt)
   -- m_Bar:update(dt,DestroyableObjects)
   m_Score:update(dt)
   m_CirclesRow:update(dt)
   m_Enemy:update(dt)

   -- Verifica la puntuación actual y actualiza la dificultad si es necesario
   self:CheckNewLevel()
   
   Collider.update()
   m_Player:update(dt)
    if love.keyboard.isDown(ExitKey) then
        ChangeScene("GameOver")
    end
end


function Scene:draw()
    m_Player:draw()
    m_Score:draw() 
    m_CirclesRow:draw()
    m_Enemy:draw()
    --futuramente un draw enemy
end
function Scene:clearAllColliders()
    Collider.clear()
    print ("Game eliminando colliders")
end
function Scene:getNewDifficultyLevel()
    -- Lógica para determinar el nuevo nivel de dificultad en función de la puntuación
    if m_Score.score >= 30 then
        return 4  -- Cambia al nivel 3 cuando se alcanzan 30 puntos
    elseif m_Score.score >= 20 then
        return 3  -- Cambia al nivel 2 cuando se alcanzan 20 puntos
    elseif m_Score.score >= 10 then
        return 2  
        -- Cambia al nivel 1 cuando se alcanzan 10 puntos
    else
        return 1  -- Nivel 1 por defecto si no se alcanza ninguna puntuación relevante
    end
end

function Scene:applyDifficultyLevel(level)
    -- Aplica las reglas específicas de cada nivel/dificultad
    if level == 1 then
        -- Reglas del nivel 1
        --ideas: spwanee un tipo de enemigo
        --la barrra mas rapida (modificar vel de la barra)
        print("nivel 1")
    elseif level == 2 then
        -- Reglas del nivel 2
        --barra mas rapida
        --enemigos:
        --enemigo que rebota en las wall (paderes)
        --ballas que llegas de "arriba" de la pantalla (literalmente una luvia)
        --halakbahr (nivel1)
            
        --
        print("nivel 2")
        
    elseif level == 3 then
        -- Reglas del nivel 3
        --lluvia en el eje x (x)
        --patro
        --halahckbar (nivel2)
        -- ... y así sucesivamente
        print("nivel 3")
    elseif level==4  then
        print("nivel 4")
    else        

    end
end

function Scene:CheckNewLevel()
    
    local newDifficultyLevel = self:getNewDifficultyLevel()
    
    if newDifficultyLevel > currentDifficultyLevel then
        currentDifficultyLevel = newDifficultyLevel
        self:applyDifficultyLevel(currentDifficultyLevel)
    end
    
end



return Scene