local Object = Object or require "lib.classic"
local Subject = require "src.Subject"  -- Ajusta la ruta de acceso al archivo Subject
local PowerUpSpeed = PowerUpSpeed or require "src.PowerUps.PowerUpSpeed"

local SpawnerPowerUps = Object:extend()

function SpawnerPowerUps:new()
    self.SpeedPowerUpSpawnTime = 2
    self.SpeedPowerUpTime = 0
    self.SpeedPowerUpSpawnTimer = 0

    self.subject = Subject:new()
    self.subject:addObserver(self)
end

function SpawnerPowerUps:update(dt)
    
    --self.SpeedPowerUpTime = self.SpeedPowerUpTime + dt
    --self.SpeedPowerUpSpawnTimer = self.SpeedPowerUpSpawnTimer + dt

    -- POWER UP SPEED
    if powerUpsVisibility.PowerUpSpeed == true then
        if self.SpeedPowerUpTime > self.SpeedPowerUpSpawnTime then
            if self.SpeedPowerUpSpawnTimer >= self.SpeedPowerUpSpawnInterval then
                local ps = PowerUpSpeed()
                table.insert(PowerUpsList, ps)
                print("POWER UP")
                self.SpeedPowerUpSpawnTimer = 0  -- Reiniciar el temporizador de aparición
            end
            self.SpeedPowerUpTime = 0
        end
    end

end



function SpawnerPowerUps:draw()
end

return SpawnerPowerUps