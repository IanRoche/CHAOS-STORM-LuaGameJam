local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Enemies=require "src.Enemies.Enemies"
local Player =Player or require "src.Player"
--local Player2 =Player2 or require "src.Player2"
local Score = require "src.score"  
local CirclesRow=CirclesRow or  require "src.CirclesRow"
local Spawner=require "src.Enemies.Spawner"
local PowerUps = require "src.PowerUps.PowerUps"
local SpawnerPowerUps = require "src.PowerUps.SpawnerPowerUps"
local Background = require "src.Background"

local m_Enemies
local m_Player
local m_Player2
local m_Score
local currentDifficultyLevel = 0  -- Nivel de dificultad actual
local m_CirclesRow
local m_Spawner
local m_PowerUps
local m_SpawnerPowerUps

function Scene:new()
    print("Game")
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed,true)
    --m_Player2 = Player2(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed,true)
    if #Collider.colliders>1 then
        
        Collider:clearAllColliders()
    end
    --m_Bar = Bar(BarStartPosX, BarStartPosY, BarWidth, BarHeight, BarRotSpeed, BarStartRotation)  -- Crea una instancia de la barra
    m_Score = Score() 
    m_CirclesRow=CirclesRow(MapCenterX,MapCenterY,10,15,1,40,math.pi)
    m_Enemies=Enemies()
    m_Spawner = Spawner()
    m_PowerUps = PowerUps()
    m_SpawnerPowerUps = SpawnerPowerUps()
    m_Background = Background()
    m_Background.scrollSpeed = 50 
end

function Scene:update(dt)
   -- m_Bar:update(dt,DestroyableObjects)
   m_Enemies:update(dt)
   m_Score:update(dt)
   m_CirclesRow:update(dt)
   m_Player:update(dt)
   --m_Player2:update(dt)
   m_Background:update(dt)
   -- Verifica la puntuación actual y actualiza la dificultad si es necesario
   self:CheckNewLevel()
   
   Collider.update()
   if love.keyboard.isDown(ExitKey) then
    ChangeScene("GameOver")
   end
   self:UpdateLevel(dt)

   m_PowerUps:update(dt)
end


function Scene:draw()
    m_Background:draw()
    m_Player:draw()
    --m_Player2:draw()
    m_Score:draw() 
    m_CirclesRow:draw()
    m_Enemies:draw()
    m_PowerUps:draw()

    --futuramente un draw enemy
end
function Scene:clearAllColliders()
    Collider.clear()
    --print ("Game eliminando colliders")
end


function Scene:getNewDifficultyLevel()
    -- Lógica para determinar el nuevo nivel de dificultad en función de la puntuación
    local newDifficultyLevel
    if _Score >= 23 then
        newDifficultyLevel = 5
    elseif _Score >= 19 then
        newDifficultyLevel = 4
    elseif _Score >= 12 then
        newDifficultyLevel = 3
    elseif _Score >=5 then
        newDifficultyLevel = 2
    else    
        newDifficultyLevel = 1 ----------------------------------------------------------------
    end
    return newDifficultyLevel
end

function Scene:applyDifficultyLevel(level)
    -- Aplica las reglas específicas de cada nivel/dificultad
    if level == 1 then
        -- Reglas del nivel 1
        --ideas: spwanee un tipo de enemigo
        --la barrra mas rapida (modificar vel de la barra)  
        -- m_Enemies:toggleEnemy("Allahakbar",false)
        -- m_Enemies:toggleEnemy("Enemy",false)
        -- m_Enemies:toggleEnemy("Bouncy",true)
        -- m_Spawner.subject:notifyObservers(2)
        m_Enemies:toggleEntity("Enemy",false,false)
        m_Enemies:toggleEntity("Allahakbar",true,true)
        m_Enemies:toggleEntity("Bouncy",false,false)
        m_Enemies:toggleEntity("PowerUpSpeed",true,true)
        
        print("tutorial")
        
    elseif level == 2 then
        -- Reglas del nivel 2
        --barra mas rapida
        --enemigos:
        --enemigo que rebota en las wall (paderes)
        --ballas que llegas de "arriba" de la pantalla (literalmente una luvia)
        --halakbahr (nivel1)
        -- --)
        -- m_Enemies:toggleEnemy("Allahakbar",false)
        -- m_Enemies:toggleEnemy("Enemy",true)
        -- m_Enemies:toggleEnemy("Bouncy",true)

        -- m_Spawner.subject:notifyObservers(0.2)
        m_Enemies:toggleEntity("Enemy",false,false)
        m_Enemies:toggleEntity("Allahakbar",true,true)
        m_Enemies:toggleEntity("Bouncy",false,false)
        m_Enemies:toggleEntity("PowerUpSpeed",false,true)

        BackGroundColor={0.5,0.2,0.5}
        AllahAkbarVelocity=100

        print("nivel 1")

    elseif level == 3 then
        -- Reglas del nivel 3
        --lluvia en el eje x (x)
        --patro
        --halahckbar (nivel2)
        -- ... y así sucesivamente

        m_Enemies:toggleEntity("Enemy",true,false)
        m_Enemies:toggleEntity("Allahakbar",true,false)
        m_Enemies:toggleEntity("Bouncy",true,false)
        m_Enemies:toggleEntity("PowerUpSpeed",true,true)

        print("nivel 2")

    elseif level==4  then
        
        m_Enemies:toggleEntity("Enemy",true,true)
        m_Enemies:toggleEntity("Allahakbar",true,true)
        m_Enemies:toggleEntity("Bouncy",true,false)
        m_Enemies:toggleEntity("PowerUpSpeed",false,true)
        
        AllahAkbarVelocity=200

        print("nivel 3")
    elseif level==5 then
        
        m_Enemies:toggleEntity("Enemy",true,true)
        m_Enemies:toggleEntity("Allahakbar",true,true)
        m_Enemies:toggleEntity("Bouncy",true,true)
        m_Enemies:toggleEntity("PowerUpSpeed",false,true)
        
        print("nivel 4")

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