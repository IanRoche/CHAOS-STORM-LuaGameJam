local Object = Object or require "lib.classic"
local Scene = Object:extend()

local Player =Player or require "src.Player"
local Score = require "src.Score"  
local Bar = require "src.Bar"  -- Importa el script de la barra


local m_Player
local m_Score
local m_Bar
local currentDifficultyLevel = 1  -- Nivel de dificultad actual


function Scene:new()
    m_Bar = Bar(BarStartPosX, BarStartPosY, BarWidth, BarHeight, BarRotSpeed, BarStartRotation)  -- Crea una instancia de la barra
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed,true)
    m_Score = Score() 
    print("Game")
end

function Scene:update(dt)
    m_Player:update(dt)
    m_Score:update(dt)
    m_Bar:update(dt,DestroyableObjects)
    -- Verifica la puntuación actual y actualiza la dificultad si es necesario
    self:CheckNewLevel()

    if love.keyboard.isDown(ExitKey) then
        ChangeScene("GameOver")
    end
end


function Scene:draw()
    m_Player:draw()
    m_Score:draw() 
    m_Bar:draw()
    --futuramente un draw enemy
end

function Scene:getNewDifficultyLevel()
    -- Lógica para determinar el nuevo nivel de dificultad en función de la puntuación
    if m_Score.score >= 30 then
        return 4  -- Cambia al nivel 3 cuando se alcanzan 30 puntos
    elseif m_Score.score >= 20 then
        return 3  -- Cambia al nivel 2 cuando se alcanzan 20 puntos
    elseif m_Score.score >= 10 then
        return 2  -- Cambia al nivel 1 cuando se alcanzan 10 puntos
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