local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Enemies=require "src.Enemies.Enemies"
local Player =Player or require "src.Player"
local Score = require "src.score"  
local CirclesRow=CirclesRow or  require "src.CirclesRow"

local m_Enemies
local m_Player
local m_Score
local currentDifficultyLevel = 0  -- Nivel de dificultad actual
local m_CirclesRow

function Scene:new()
    print("Game")
    if #Collider.colliders>1 then
        
        Collider:clearAllColliders()
    end
    --m_Bar = Bar(BarStartPosX, BarStartPosY, BarWidth, BarHeight, BarRotSpeed, BarStartRotation)  -- Crea una instancia de la barra
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed,true)
    m_Score = Score() 
    m_CirclesRow=CirclesRow(MapCenterX,MapCenterY,10,15,1,40,math.pi)
    m_Enemies=Enemies()
end

function Scene:update(dt)
   -- m_Bar:update(dt,DestroyableObjects)
   m_Score:update(dt)
   
   m_CirclesRow:update(dt)
   m_Player:update(dt)
   
   -- Verifica la puntuación actual y actualiza la dificultad si es necesario
   self:CheckNewLevel()
   
   Collider.update()
   if love.keyboard.isDown(ExitKey) then
    ChangeScene("GameOver")
   end
   self:UpdateLevel(dt)
   m_Enemies:update(dt)
end


function Scene:draw()
    m_Player:draw()
    m_Score:draw() 
    m_CirclesRow:draw()
    m_Enemies:draw()
    --futuramente un draw enemy
end
function Scene:clearAllColliders()
    Collider.clear()
    print ("Game eliminando colliders")
end


function Scene:getNewDifficultyLevel()
    -- Lógica para determinar el nuevo nivel de dificultad en función de la puntuación
    local newDifficultyLevel
    if _Score >= 15 then
        newDifficultyLevel = 4
    elseif _Score >= 10 then
        newDifficultyLevel = 3
    elseif _Score >= 5 then
        newDifficultyLevel = 2
    else
        newDifficultyLevel = 1
    end
    return newDifficultyLevel
end

function Scene:applyDifficultyLevel(level)
    -- Aplica las reglas específicas de cada nivel/dificultad
    if level == 1 then
        -- Reglas del nivel 1
        --ideas: spwanee un tipo de enemigo
        --la barrra mas rapida (modificar vel de la barra)  
        print("nivel 1++")
        m_Enemies:toggleEnemy("Allahakbar",false)
    elseif level == 2 then
        -- Reglas del nivel 2
        --barra mas rapida
        --enemigos:
        --enemigo que rebota en las wall (paderes)
        --ballas que llegas de "arriba" de la pantalla (literalmente una luvia)
        --halakbahr (nivel1)
        --
        m_Enemies:toggleEnemy("Allahakbar",true)
        print("nivel 2")
    elseif level == 3 then
        -- Reglas del nivel 3
        --lluvia en el eje x (x)
        --patro
        --halahckbar (nivel2)
        -- ... y así sucesivamente

        print("nivel 3")
        m_Enemies:toggleEnemy("Allahakbar",false)

    elseif level==4  then
        print("nivel 4")
    else        

    end
end

function Scene:UpdateLevel(dt)
if currentDifficultyLevel==1 then
    self:UpdateLevel1(dt)
elseif  currentDifficultyLevel==2 then
    self:UpdateLevel2(dt)
elseif  currentDifficultyLevel==3 then
    self:UpdateLevel3(dt)
end
end

function Scene:CheckNewLevel()
    local newDifficultyLevel = self:getNewDifficultyLevel()
--    print("new difficulty level:"..newDifficultyLevel)
    if newDifficultyLevel > currentDifficultyLevel then
        currentDifficultyLevel = newDifficultyLevel
        self:applyDifficultyLevel(currentDifficultyLevel)
    end
end

function Scene:UpdateLevel1(dt)
--print ("level 1")
end
function Scene:UpdateLevel2(dt)
--print ("level 2")
end
function Scene:UpdateLevel3(dt)
--print ("level 3")
end

return Scene