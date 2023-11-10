local Object = Object or require "lib.classic"
local Background = Object:extend()

function Background:new()
    self.bgImage = love.graphics.newImage("src/Textures/FondoParticular.png")
    self.scrollSpeed = 50  -- velocidad de desplazamiento
    self.y = 0  -- Posición inicial en el eje Y
end

function Background:update(dt)
    self.y = self.y + self.scrollSpeed * dt

    if self.y >= self.bgImage:getHeight() then
        self.y = 0
    end
end

function Background:draw()--TOCAD LOQUE QUERAIS (el background que mas os guste!!!)
    love.graphics.setBackgroundColor(BackGroundColor)--Color actual Gris oscuro   -- Gris medio (0.5, 0.5, 0.5)
    love.graphics.draw(self.bgImage, 0, self.y)
    love.graphics.draw(self.bgImage, 0, self.y - self.bgImage:getHeight())
    --love.graphics.reset(love.graphics.setBackgroundColor(BackGroundColor))
end


return Background
