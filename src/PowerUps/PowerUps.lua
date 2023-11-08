local Object = Object or require "lib.classic"
local PowerUps = Object:extend()
local PowerUpSpeed = require "src.PowerUps.PowerUpSpeed"
local SpawnerPowerUps = require "src.PowerUps.SpawnerPowerUps"

PowerUpsList={}

-- Tabla para llevar un seguimiento de qué enemigos deben aparecer
 powerUpsVisibility = {
    PowerUpSpeed = false,  -- Por defecto, aparece
}

function PowerUps:new()
    
    PowerUpSpeed:new()

end

function PowerUps:update(dt)
    SpawnerPowerUps:update(dt)


    if powerUpsVisibility.PowerUpSpeed then
        PowerUpSpeed:update(dt)
    end

end

function PowerUps:draw()

    for _, powerUps in ipairs(PowerUpsList) do
        powerUps:draw()
    end

    if powerUpsVisibility.PowerUpSpeed then
        PowerUpSpeed:draw()
    end
end


function DestroyPowerUp(powerUpType)
    for i, powerUp in ipairs(EnemyList) do
        if powerUp.type == powerUpType then
            table.remove(PowerUpsList, i)
            break
        end
    end
end
return PowerUps