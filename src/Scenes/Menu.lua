local Object = Object or require "lib.classic"
local Scene = Object:extend()

function Scene:new()
    self.playButton = {
        x = love.graphics.getWidth() / 2 - 100,
        y = love.graphics.getHeight() / 2 - 30,
        width = 200,
        height = 60,
        text = "Jugar"
    }

    self.quitButton = {
        x = love.graphics.getWidth() / 2 - 100,
        y = love.graphics.getHeight() / 2 + 30,
        width = 200,
        height = 60,
        text = "Salir"
    }
end

function Scene:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    local buttonClicked = nil

    if love.mouse.isDown(1) then
        -- Verificar si se hizo clic en el botón "Jugar"
        if mouseX >= self.playButton.x and mouseX <= self.playButton.x + self.playButton.width and
           mouseY >= self.playButton.y and mouseY <= self.playButton.y + self.playButton.height then
            buttonClicked = "play"
        end

        -- Verificar si se hizo clic en el botón "Salir"
        if mouseX >= self.quitButton.x and mouseX <= self.quitButton.x + self.quitButton.width and
           mouseY >= self.quitButton.y and mouseY <= self.quitButton.y + self.quitButton.height then
            buttonClicked = "quit"
        end
    end

    if buttonClicked == "play" then
        ChangeScene("Game")
    elseif buttonClicked == "quit" then
        love.event.quit()
    end
end
function Scene:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.playButton.x, self.playButton.y, self.playButton.width, self.playButton.height)
    love.graphics.rectangle("line", self.quitButton.x, self.quitButton.y, self.quitButton.width, self.quitButton.height)

    love.graphics.print(self.playButton.text, self.playButton.x + 20, self.playButton.y + 10)
    love.graphics.print(self.quitButton.text, self.quitButton.x + 20, self.quitButton.y + 10)
end
return Scene