local Object = Object or require "lib.classic"
local SpawnerPowerUps = Object:extend()
local PowerUpSpeed = require "src.PowerUps.PowerUpSpeed"

function SpawnerPowerUps:new()
    self.spawnTime = 5  -- Tiempo entre generaciones de power-ups
    self.spawnTimer = 0  -- Temporizador para controlar la generación de power-ups
end

function SpawnerPowerUps:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= self.spawnTime then
        if PowerUpsVisibility.PowerUpSpeed then  -- Verifica la visibilidad del tipo de power-up
            self:spawnPowerUp()
        end
        self.spawnTimer = 0  -- Reiniciar el temporizador de generación
    end
end

function SpawnerPowerUps:spawnPowerUp()
    local powerUp = PowerUpSpeed()
    print ("Poweruplist: "..#PowerUpsList)
    table.insert(PowerUpsList, powerUp)
end

return SpawnerPowerUps
