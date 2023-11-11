local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Enemies = require "src.Enemies.Enemies"
local Player = Player or require "src.Player"
local Score = require "src.score"  
local CirclesRow = CirclesRow or require "src.CirclesRow"
local Spawner = require "src.Enemies.Spawner"
local PowerUps = require "src.PowerUps.PowerUps"
local SpawnerPowerUps = require "src.PowerUps.SpawnerPowerUps"
local Background = require "src.Background"

local m_Enemies
local m_Player
local m_Score
local currentDifficultyLevel = 0
local m_CirclesRow
local m_Spawner
local m_PowerUps
local m_SpawnerPowerUps
local m_Background

function Scene:new()
    print("Game")
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed, true)
    if #Collider.colliders > 1 then
        Collider:clearAllColliders()
    end
    m_Score = Score() 
    m_CirclesRow = CirclesRow(MapCenterX, MapCenterY, 10, 15, CirclesRowRotationSpeed, 40, math.pi)
    m_Enemies = Enemies()
    m_Spawner = Spawner()
    m_PowerUps = PowerUps()
    m_SpawnerPowerUps = SpawnerPowerUps()
    m_Background = Background()
    m_Background.scrollSpeed = 50 
end

function Scene:update(dt)
    m_Enemies:update(dt)
    m_Score:update(dt)
    m_CirclesRow:update(dt)
    m_Player:update(dt)
    m_Background:update(dt)
    self:checkNewLevel()
    Collider.update()
    if love.keyboard.isDown(ExitKey) then
        ChangeScene("GameOver")
    end
    self:updateLevel(dt)
    m_PowerUps:update(dt)
end

function Scene:draw()
    m_Background:draw()
    m_Player:draw()
    m_Score:draw() 
    m_CirclesRow:draw()
    m_Enemies:draw()
    m_PowerUps:draw()
end

function Scene:clearAllColliders()
    Collider.clear()
end

function Scene:getNewDifficultyLevel()
    local newDifficultyLevel
    if _Score >= 23 then
        newDifficultyLevel = 5
    elseif _Score >= 15 then
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
    if level == 1 then
        m_Enemies:toggleEntity("EnemyFollow", false, false)
        m_Enemies:toggleEntity("Allahakbar", true, true)
        m_Enemies:toggleEntity("Bouncy", true, true)
        m_Enemies:toggleEntity("PowerUpSpeed", false, true)
    elseif level == 2 then
        m_Enemies:toggleEntity("EnemyFollow", false, false)
        m_Enemies:toggleEntity("Allahakbar", true, true)
        m_Enemies:toggleEntity("Bouncy", false, false)
        m_Enemies:toggleEntity("PowerUpSpeed", false, true)
        self:changeCirclesRowValues(1, 50, 100, 5, 0.7)
        ChangeBackgroundColor(0.5, 0.2, 0.5, 1)
        AllahAkbarVelocity = 100
    elseif level == 3 then
        m_Enemies:toggleEntity("EnemyFollow", true, false)
        m_Enemies:toggleEntity("Allahakbar", true, false)
        m_Enemies:toggleEntity("Bouncy", true, false)
        m_Enemies:toggleEntity("PowerUpSpeed", false, true)
        ChangeBackgroundColor(0, 0.4, 0.3, 1)
    elseif level == 4  then
        m_Enemies:toggleEntity("EnemyFollow", true, true)
        m_Enemies:toggleEntity("Allahakbar", true, true)
        m_Enemies:toggleEntity("Bouncy", true, false)
        m_Enemies:toggleEntity("PowerUpSpeed", false, true)
        AllahAkbarVelocity = 200
    elseif level == 5 then
        m_Enemies:toggleEntity("EnemyFollow", true, true)
        m_Enemies:toggleEntity("Allahakbar", true, true)
        m_Enemies:toggleEntity("Bouncy", true, true)
        m_Enemies:toggleEntity("PowerUpSpeed", false, true)
    end
end

function Scene:updateLevel(dt)
    if currentDifficultyLevel == 1 then
        self:updateLevel1(dt)
    elseif currentDifficultyLevel == 2 then
        self:updateLevel2(dt)
    elseif currentDifficultyLevel == 3 then
        self:updateLevel3(dt)
    elseif currentDifficultyLevel == 4 then
        self:updateLevel3(dt)
    elseif currentDifficultyLevel == 5 then
        self:updateLevel3(dt)
    end
end

function Scene:checkNewLevel()
    local newDifficultyLevel = self:getNewDifficultyLevel()
    if newDifficultyLevel > currentDifficultyLevel then
        currentDifficultyLevel = newDifficultyLevel
        self:applyDifficultyLevel(currentDifficultyLevel)
    end
end

function Scene:updateLevel1(dt)
    for i, rgb in ipairs(BackGroundColor) do
        BackGroundColor[i] = BackGroundColor[i] + 0.001
    end
end

function Scene:updateLevel2(dt)
    -- Level 2 update logic
     -- Patrón de cambio de color del fondo en tonos morados
     local purpleDark = {0.2, 0, 0.2, 1}  -- Morado oscuro
     local purpleLight = {0.7, 0, 0.7, 1}  -- Morado claro
 
     -- Velocidad de cambio de color (ajusta según tus preferencias)
     local colorChangeSpeed = 1
 
     -- Cálculo de valores RGB en función del tiempo
     local time = love.timer.getTime()
     local r = 0.5 + 0.5 * math.sin(colorChangeSpeed * time)
     local g = 0
     local b = 0.5 + 0.5 * math.cos(colorChangeSpeed * time)
     local a = 1
 
     -- Cambia el color de fondo
     ChangeBackgroundColor(r, g, b, a)

end

function Scene:updateLevel3(dt)
    local time = love.timer.getTime()

    -- Cambia el color del fondo con un patrón de arcoíris
    local frequency = 1
    local red = math.sin(frequency * time) * 0.5 + 0.5
    local green = math.sin(frequency * time + (2 * math.pi / 3)) * 0.5 + 0.5
    local blue = math.sin(frequency * time + (4 * math.pi / 3)) * 0.5 + 0.5

    -- Asigna los valores al color de fondo
    ChangeBackgroundColor(red, green, blue, 1)
end


function Scene:changeCirclesRowValues(rotationSpeed, minCircleSpacing, maxCircleSpacing, changeFrequency, changeSpeed)
    CirclesRowRotationSpeed = rotationSpeed
    CirclesRowMinCirclesSpacing = minCircleSpacing
    CirclesRowMaxCircleSpacing = maxCircleSpacing
    CirclesRowChangeFrequency = changeFrequency
    CirclesRowChangeSpeed = changeSpeed
end

function ChangeBackgroundColor(r, g, b, a)
    love.graphics.setBackgroundColor(r, g, b, a)
end

return Scene
