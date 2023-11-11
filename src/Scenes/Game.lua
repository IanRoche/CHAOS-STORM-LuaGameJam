local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Enemies =Enemies or require "src.Enemies.Enemies"
local Player = Player or require "src.Player"
local Score =Score or require "src.score"  
local CirclesRow = CirclesRow or require "src.CirclesRow"
local PowerUps =PowerUps or require "src.PowerUps.PowerUps"
local Background =Background or require "src.Background"

local m_Enemies
local m_Player
local m_Score
local m_currentDifficultyLevel = 0
local m_CirclesRow
local m_PowerUps
local m_Background

function Scene:new()
    love.mouse.setVisible(false)  -- Oculta el cursor del mouse al iniciar el juego
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed, true)
    if #Collider.colliders > 1 then
        Collider:clearAllColliders()
    end
    m_Score = Score() 
    m_CirclesRow = CirclesRow(MapCenterX, MapCenterY, 10, 15, CirclesRowRotationSpeed, 40, math.pi)
    m_Enemies = Enemies()
    m_PowerUps = PowerUps()
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
        ChangeScene("Menu")
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
    
    if m_currentDifficultyLevel == 1 then
        self:drawBlinkingCircle()
    end
end

function Scene:drawBlinkingCircle()
    local l_radius = 40
    local l_blinkFrequency = 5

    local l_visibility = math.sin(love.timer.getTime() * l_blinkFrequency)
    l_visibility = (l_visibility + 1) / 2

    local l_color = {1, 0, 0, l_visibility}
    local l_lineWidth = 5

    self:drawCircle(m_Player.x, m_Player.y, l_radius, "line", l_color, l_lineWidth)
end

function Scene:drawCircle(l_x, l_y, l_radius, l_mode, l_color, l_lineWidth)
    local r, g, b, a = love.graphics.getColor()
    local lw = love.graphics.getLineWidth()

    love.graphics.setColor(l_color)
    love.graphics.setLineWidth(l_lineWidth)
    love.graphics.circle(l_mode, l_x, l_y, l_radius)

    love.graphics.setColor(r, g, b, a)
    love.graphics.setLineWidth(lw)
end

function Scene:clearAllColliders()
    Collider.clear()
end

function Scene:getNewDifficultyLevel()
    local l_newDifficultyLevel
    if _Score >= ScoreToLevel5 then
        l_newDifficultyLevel = 5
    elseif _Score >= ScoreToLevel4 then
        l_newDifficultyLevel = 4
    elseif _Score >= ScoreToLevel3 then
        l_newDifficultyLevel = 3
    elseif _Score >= ScoreToLevel2 then
        l_newDifficultyLevel = 2
    else    
        l_newDifficultyLevel = 1
    end
    return l_newDifficultyLevel
end

function Scene:ToggleEntities(l_EnemyFollow, l_Allahakbar, l_Bouncy, l_PowerUpSpeed)
    self:CheckToggleEntity(l_EnemyFollow, "EnemyFollow", true, true)
    self:CheckToggleEntity(l_Allahakbar, "Allahakbar", true, true)
    self:CheckToggleEntity(l_Bouncy, "Bouncy", true, true)
    self:CheckToggleEntity(l_PowerUpSpeed, "PowerUpSpeed", false, true)
end

function Scene:CheckToggleEntity(l_shouldToggle, l_entityName, ...)
    if l_shouldToggle then
        m_Enemies:toggleEntity(l_entityName, ...)
    end
end

function Scene:ChangeSpawnIntervals(l_AllahAkbar, l_EnemyFollow, l_Bouncy)
    AllahAkbarSpawnInterval = l_AllahAkbar  -- Intervalo en segundos entre la aparición de Allahakbar
    EnemySpawnInterval = l_EnemyFollow
    BouncySpawnInterval = l_Bouncy
end

function Scene:UpdateEnemiesStats(l_akbarVelocity, l_followVelocity, l_bouncyVelocity, l_maxWallHits)
    AllahAkbarVelocity = l_akbarVelocity
    EnemyFollowVelocity = l_followVelocity
    BouncyVelocity = l_bouncyVelocity
    BouncyMaxWallHits = l_maxWallHits
end

function Scene:applyDifficultyLevel(l_level)
    if l_level == 1 then
        --Enemigos activos
        self:ToggleEntities(true, true, true, true)
        
        --Modificaciones Spawn Enemigos
        self:ChangeSpawnIntervals(2, 2, 2)
        
        --Modificaciones Enemigos
        self:UpdateEnemiesStats(60, 60, 60, 2)
    elseif l_level == 2 then
        --Enemigos activos
        self:ToggleEntities(true, false, false, true)
        
        --Modificaciones Spawn Enemigos
        self:ChangeSpawnIntervals(2, 1, 2)
        
        --Modificaciones Enemigos
        self:changeCirclesRowValues(1, 50, 100, 5, 0.7)
        self:UpdateEnemiesStats(80, 100, 90, 4)
    elseif l_level == 3 then
        --Enemigos activos
        self:ToggleEntities(true, true, false, true)
        
        --Modificaciones Spawn Enemigos
        self:ChangeSpawnIntervals(2, 1, 2)
        
        --Modificaciones Enemigos
        self:changeCirclesRowValues(1.3, 30, 150, 5, 2)
        self:UpdateEnemiesStats(100, 150, 100, 5)
    elseif l_level == 4 then
        --Enemigos activos
        self:ToggleEntities(true, true, true, true)
        
        --Modificaciones Spawn Enemigos
        self:ChangeSpawnIntervals(1, 1, 2)
        
        --Modificaciones Enemigos
        self:changeCirclesRowValues(1.6, 50, 100, 5, 2)
        self:UpdateEnemiesStats(150, 200, 100, 7)
    elseif l_level == 5 then
        --Enemigos activos
        self:ToggleEntities(true, true, true, true)
        
        --Modificaciones Spawn Enemigos
        self:ChangeSpawnIntervals(0.1, 0.1, 0.1)
        
        --Modificaciones Enemigos
        self:changeCirclesRowValues(2, 70, 200, 5, 0.4)
        self:UpdateEnemiesStats(170, 200, 100, 10)
    end
end

function Scene:updateLevel(dt)
    if m_currentDifficultyLevel == 1 then
        self:updateLevel1(dt)
    elseif m_currentDifficultyLevel == 2 then
        self:updateLevel2(dt)
    elseif m_currentDifficultyLevel == 3 then
        self:updateLevel3(dt)
    elseif m_currentDifficultyLevel == 4 then
        self:updateLevel4(dt)
    elseif m_currentDifficultyLevel == 5 then
        self:updateLevel5(dt)
    end
end

function Scene:checkNewLevel()
    local l_newDifficultyLevel = self:getNewDifficultyLevel()
    if l_newDifficultyLevel > m_currentDifficultyLevel then
        m_currentDifficultyLevel = l_newDifficultyLevel
        self:applyDifficultyLevel(m_currentDifficultyLevel)
    end
end

function Scene:updateLevel1(dt)
    ChangeBackgroundColorLinear(BackGroundColor, 0.001)
    self:updateBarColorLinear(BarColor, 0.001)
end

function Scene:updateLevel2(dt)
    local purpleDark = {0.4, 0, 0.4, 1}
    local purpleLight = {0.6, 0, 0.6, 1}
    local colorChangeSpeed = 1
    local r, g, b, a = CalculateColorFromPattern(purpleDark, purpleLight, colorChangeSpeed)
    ChangeBackgroundColor(r, g, b, a)
    self:updateBarColorPattern(BarColor, purpleDark, purpleLight, colorChangeSpeed)
end

function Scene:updateLevel3(dt)
    local green = CalculateSinusoidalColorComponent(0, 1, 1, love.timer.getTime(), 1)
    ChangeBackgroundColor(0, green, 0, 1)
    self:updateBarColorSinusoidal(BarColor, 0, 1, 1, love.timer.getTime(), 1)
end

function Scene:updateLevel4(dt)
    local yellow = CalculateSinusoidalColorComponent(0, 1, 1, love.timer.getTime(), 1)
    local orange = CalculateSinusoidalColorComponent(math.pi, 1, 1, love.timer.getTime(), 1)
    ChangeBackgroundColor(yellow, orange, 0, 1)
    self:updateBarColorSinusoidal(BarColor, 0, 1, 1, love.timer.getTime(), 1)
end

function Scene:updateLevel5(dt)
    local red = CalculateSinusoidalColorComponent(0, 1, 1, love.timer.getTime(), 1)
    local green = CalculateSinusoidalColorComponent(2 * math.pi / 3, 1, 1, love.timer.getTime(), 1)
    local blue = CalculateSinusoidalColorComponent(4 * math.pi / 3, 1, 1, love.timer.getTime(), 1)
    ChangeBackgroundColor(red, green, blue, 1)
    self:updateBarColorRainbow(BarColor, love.timer.getTime())
end

function Scene:updateBarColorLinear(colorTable, rate)
    for i, component in ipairs(colorTable) do
        colorTable[i] = component + rate
    end
end

function Scene:updateBarColorPattern(colorTable, colorDark, colorLight, speed)
    local r, g, b, a = CalculateColorFromPattern(colorDark, colorLight, speed)
    colorTable[1], colorTable[2], colorTable[3], colorTable[4] = r, g, b, a
end

function Scene:updateBarColorSinusoidal(colorTable, phaseShift, amplitude, offset, time, frequency)
    local value = CalculateSinusoidalColorComponent(phaseShift, amplitude, offset, time, frequency)
    colorTable[2] = value
end

function Scene:updateBarColorRainbow(colorTable, time)
    local red = CalculateSinusoidalColorComponent(0, 1, 1, time, 1)
    local green = CalculateSinusoidalColorComponent(2 * math.pi / 3, 1, 1, time, 1)
    local blue = CalculateSinusoidalColorComponent(4 * math.pi / 3, 1, 1, time, 1)
    colorTable[1], colorTable[2], colorTable[3] = red, green, blue
end
-- UTILITY
function ChangeBackgroundColorLinear(colorTable, rate)
    for i, component in ipairs(colorTable) do
        colorTable[i] = component + rate
    end
end

function CalculateColorFromPattern(colorDark, colorLight, speed)
    local time = love.timer.getTime()
    local r = (colorDark[1] + colorLight[1]) / 2 + 0.2 * math.sin(speed * time)
    local g = (colorDark[2] + colorLight[2]) / 2
    local b = (colorDark[3] + colorLight[3]) / 2 + 0.2 * math.cos(speed * time)
    local a = (colorDark[4] + colorLight[4]) / 2
    return r, g, b, a
end

function CalculateSinusoidalColorComponent(phaseShift, amplitude, offset, time, frequency)
    return amplitude * math.sin(frequency * time + phaseShift) + offset
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
