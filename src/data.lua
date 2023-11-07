local Object = Object or require "lib.classic"
local Data = Object:extend()

Data = {}

function Data:load()
    -- MAP
Width, Height = love.graphics.getDimensions()
CenterRadius = 80
OriginX, OriginY = 0,0
MapCenterX, MapCenterY= Width/2, Height/2
--Miscelanius
DestroyableObjects={}
--PLAYER
PlayerStartPosX, PlayerStartPosY =MapCenterX-MapCenterX/2,MapCenterY+MapCenterY/2
PlayerSpeed=400
PlayerRadius=20
PlayerPosition={x=PlayerStartPosX, y=PlayerStartPosY}
--BAR
BarWidth, BarHeight=20,1000
BarStartRotation =math.pi/2
BarRotSpeed=1
BarColor={0.0,1.0,1.0,1.0}
BarStartPosX, BarStartPosY =MapCenterX-BarWidth/2,MapCenterY-BarHeight/2
-- MENU
IsPlaying = false
ButtonList = {}
ButtonWidth = Width/3
ButtonHeight = 50
ButtonOffset = 10
MenuFontSize = 30
ExitKey = "escape"
-- GAME OVER
GameOverColor = {1,0,0,1}
LoseColor = {1, 0, 0, 1}
GameOverText = ""
GameOverFontSize = 70

-- COLORS
BallColor = {1.0, 1.0, 1.0, 1.0}
PaddleColor = {0.5, 1.0, 1.0, 1.0}
MapScoreColor = {0.5, 0.5, 1.0, 1.0}
end

-- SCORE
_Score=0
CurrentDifficultyLevel =1

--SPAWNER
AllahakbarSpawnInterval = 3  -- Intervalo en segundos entre la aparición de Allahakbar
EnemySpawnInterval = 3 

--ENEMIES
----ALLAHAKBAR
AllahAkbarVelocity =100

return Data