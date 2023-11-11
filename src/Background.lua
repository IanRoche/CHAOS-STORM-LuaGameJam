local Object = Object or require "lib.classic"
local Background = Object:extend()

function Background:new()
    self.bgImage = love.graphics.newImage("src/Textures/FondoParticular.png")
    self.scrollSpeed = 50
    self.y = 0
end

function Background:update(dt)
    self.y = self.y + self.scrollSpeed * dt

    if self.y >= self.bgImage:getHeight() then
        self.y = 0
    end
end

function Background:draw()
    love.graphics.setBackgroundColor(BackGroundColor)
    love.graphics.draw(self.bgImage, 0, self.y)
    love.graphics.draw(self.bgImage, 0, self.y - self.bgImage:getHeight())
end


return Background
