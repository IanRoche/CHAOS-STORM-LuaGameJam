local Object = Object or require "lib.classic"
local PowerUps = Object:extend()
local SpawnerPowerUps = require "src.PowerUps.SpawnerPowerUps"

PowerUpsList = {}
PowerUpsVisibility = {
    PowerUpSpeed = false,
}

function PowerUps:new()
    SpawnerPowerUps:new()
end

function PowerUps:update(dt)
    SpawnerPowerUps:update(dt)

    for _, powerUp in ipairs(PowerUpsList) do
        powerUp:update(dt)
    end
end

function PowerUps:draw()
    for _, powerUp in ipairs(PowerUpsList) do
        powerUp:draw()
    end
end

return PowerUps
