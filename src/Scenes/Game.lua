local Object = Object or require "lib.classic"
local Scene = Object:extend()
local Player =Player or require "src.Player"
local Score = require "src.Score"  


local m_Player
local m_Score
local currentDifficultyLevel = 1  -- Nivel de dificultad actual


function Scene:new()
    m_Player = Player(PlayerStartPosX, PlayerStartPosY, PlayerRadius, PlayerSpeed)
    m_Score = Score() 
    print("Game")
end

function Scene:update(dt)
    m_Player:update(dt)
    m_Score:update(dt)
    -- Verifica la puntuación actual y actualiza la dificultad si es necesario
    local newDifficultyLevel = self:getNewDifficultyLevel()
    
    if newDifficultyLevel > currentDifficultyLevel then
        currentDifficultyLevel = newDifficultyLevel
        self:applyDifficultyLevel(currentDifficultyLevel)
    end
    
    if love.keyboard.isDown(ExitKey) then
        ChangeScene("GameOver")
    end
end

function Scene:getNewDifficultyLevel()
    -- Lógica para determinar el nuevo nivel de dificultad en función de la puntuación
    if m_Score.score >= 30 then
        return 3  -- Cambia al nivel 3 cuando se alcanzan 30 puntos
    elseif m_Score.score >= 20 then
        return 2  -- Cambia al nivel 2 cuando se alcanzan 20 puntos
    elseif m_Score.score >= 10 then
        return 1  -- Cambia al nivel 1 cuando se alcanzan 10 puntos
    else
        return 1  -- Nivel 1 por defecto si no se alcanza ninguna puntuación relevante
    end
end

function Scene:applyDifficultyLevel(level)
    -- Aplica las reglas específicas de cada nivel/dificultad
    if level == 1 then
        -- Reglas del nivel 1
        print("nivel 1")
    elseif level == 2 then
        -- Reglas del nivel 2
        print("nivel 2")

    elseif level == 3 then
        -- Reglas del nivel 3
    -- ... y así sucesivamente
        print("nivel 3")

    end
end

function Scene:draw()
    m_Player:draw()
    m_Score:draw() 
end


return Scene