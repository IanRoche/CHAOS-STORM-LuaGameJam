local Object = Object or require "lib.classic"
local SpawnerPowerUps = Object:extend()
local PowerUpSpeed = require "src.PowerUps.PowerUpSpeed"

function SpawnerPowerUps:new()
    self.spawnTime = 3.5  -- Tiempo entre generaciones de power-ups
    self.spawnTimer = 0  -- Temporizador para controlar la generación de power-ups
end

function SpawnerPowerUps:update(dt)
    self:updateSpawnTimer(dt)

    if self:shouldSpawnPowerUp() then
        self:spawnPowerUp()
        self:resetSpawnTimer()
    end
end

function SpawnerPowerUps:updateSpawnTimer(dt)
    self.spawnTimer = self.spawnTimer + dt
end

function SpawnerPowerUps:shouldSpawnPowerUp()
    return self.spawnTimer >= self.spawnTime and PowerUpsVisibility.PowerUpSpeed
end

function SpawnerPowerUps:spawnPowerUp()
    local powerUp = PowerUpSpeed()
    table.insert(PowerUpsList, powerUp)
end

function SpawnerPowerUps:resetSpawnTimer()
    self.spawnTimer = 0
end

return SpawnerPowerUps
