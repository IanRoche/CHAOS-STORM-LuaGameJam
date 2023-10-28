local Object = Object or require "lib.classic"
local Data = Object:extend()

Data = {}

function Data:load()
    -- MAP
Width, Height = love.graphics.getDimensions()
CenterRadius = 80
OriginX, OriginY = 0,0
MapCenterX, MapCenterY= Width/2, Height/2

--PLAYER
PlayerStartPosX, PlayerStartPosY =MapCenterX,MapCenterY
PlayerSpeed=400
PlayerRadius=20
-- MENU
IsPlaying = false
ButtonList = {}
ButtonWidth = Width/3
ButtonHeight = 50
ButtonOffset = 10
MenuFontSize = 30
ExitKey = "escape"
-- GAME OVER
GameOverColor = {}
WinColor = {0, 1, 0, 1}
LoseColor = {1, 0, 0, 1}
GameOverText = ""
GameOverFontSize = 70

-- COLORS
BallColor = {1.0, 1.0, 1.0, 1.0}
PaddleColor = {0.5, 1.0, 1.0, 1.0}
MapScoreColor = {0.5, 0.5, 1.0, 1.0}
end

-- SCOREBOARD
Scores = {}


return Data