local Object = Object or require "lib.classic"
local Data = Object:extend()

function Data:load()
    self:loadMap()
    self:loadPlayer()
    self:loadMenu()
    self:loadGameOver()
    self:loadScore()
    self:loadSpawnerEnemies()
    self:loadEnemySettings()
    self:loadBackground()
    self:loadCircleRow()
    self:loadMiscellaneous()
end

function Data:loadMap()
    Width, Height = love.graphics.getDimensions()
    MapCenterX, MapCenterY = Width / 2, Height / 2
end

function Data:loadPlayer()
    PlayerStartPosX, PlayerStartPosY = MapCenterX - MapCenterX / 2, MapCenterY + MapCenterY / 2
    PlayerSpeed = 400
    PlayerRadius = 20
    PlayerPosition = {x = PlayerStartPosX, y = PlayerStartPosY}
end

function Data:loadMenu()
    IsPlaying = false
    ButtonList = {}
    ButtonWidth = Width / 3
    ButtonHeight = 50
    ButtonOffset = 10
    MenuFontSize = 30
    ExitKey = "escape"
end

function Data:loadGameOver()
    GameOverColor = {1, 0, 0, 1}
    LoseColor = {1, 0, 0, 1}
    GameOverText = ""
    GameOverFontSize = 70
    GameoverEscFontSize = 20
end

function Data:loadScore()
    _Score = 0
    CurrentDifficultyLevel = 1

    ScoreToLevel2=5
    ScoreToLevel3=25
    ScoreToLevel4=35
    ScoreToLevel5=50

end

function Data:loadSpawnerEnemies()
    AllahAkbarSpawnInterval = 2
    EnemySpawnInterval = 1
    BouncySpawnInterval = 1
end

function Data:loadEnemySettings()
    AllahAkbarVelocity = 100
    EnemyFollowVelocity = 100
    BouncyVelocity = 100
    BouncyMaxWallHits = 4
end

function Data:loadBackground()
    BackGroundColor = {0.1, 0.1, 0.1}
end

function Data:loadCircleRow()
    BarColor = {0.0, 1.0, 1.0, 1.0}
    CirclesRowRotationSpeed = 1
    CirclesRowMinCirclesSpacing = 50
    CirclesRowMaxCircleSpacing = 100
    CirclesRowChangeFrequency = 1.2
    CirclesRowChangeSpeed = 0.7
end

function Data:loadMiscellaneous()
    DestroyableObjects = {}
end

return Data
