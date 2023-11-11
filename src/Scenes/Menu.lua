local Object = Object or require "lib.classic"
local Scene = Object:extend()

-- CONSTANTS
local BUTTON_WIDTH = 200
local BUTTON_HEIGHT = 60
local BUTTON_SPACING = 20
local TITLE_Y = 200
local CENTER_Y = love.graphics.getHeight() / 1.75
local MENU_FONT_SIZE = 100

function Scene:new()
    self.buttons = {}
    self:createButtons()
    self.menuFont = love.graphics.newFont("src/Fonts/Storm Gust.ttf", MENU_FONT_SIZE)
    self.backgroundImage = love.graphics.newImage("src/Textures/otroFondo.png")
end

function Scene:draw()
    self:drawBackground()
    self:drawTitle()
    self:drawButtons()
end

function Scene:update(dt)
    self:updateButtonStates()
    self:checkButtonActions()
end

function Scene:keypressed(key)
    if key == "return" then
        self:handleEnterKey()
    elseif key == "up" or key == "down" then
        self:handleArrowKeys(key)
    end
end

function Scene:drawBackground()
    love.graphics.draw(self.backgroundImage, 0, 0, 0, love.graphics.getWidth() / self.backgroundImage:getWidth(), love.graphics.getHeight() / self.backgroundImage:getHeight())
end

function Scene:drawTitle()
    local title = "C H A O S   S T O R M"
    local titleX = (love.graphics.getWidth() - self.menuFont:getWidth(title)) / 2
    local titleY = 200

    love.graphics.setFont(self.menuFont)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(title, titleX + 5, titleY + 5)
    love.graphics.print(title, titleX - 5, titleY - 5)
    love.graphics.setColor(1, 0.1, 0.2)
    love.graphics.print(title, titleX, titleY)
    love.graphics.setFont(love.graphics.newFont())
end

function Scene:createButtons()
    self.buttons.play = self:createButton("PLAY", 1)
    self.buttons.quit = self:createButton("EXIT", 2)
end

function Scene:createButton(text, index)
    local position = self:calculateButtonPosition(index)

    return {
        x = position.x,
        y = position.y,
        width = BUTTON_WIDTH,
        height = BUTTON_HEIGHT,
        text = text,
        isHovered = false,
        isSelected = false
    }
end

function Scene:calculateButtonPosition(index)
    return {
        x = (love.graphics.getWidth() - BUTTON_WIDTH) / 2,
        y = CENTER_Y + (index - 1) * (BUTTON_HEIGHT + BUTTON_SPACING)
    }
end

function Scene:updateButtonStates()
    for _, button in pairs(self.buttons) do
        local mouseX, mouseY = love.mouse.getPosition()
        button.isHovered = mouseX >= button.x and mouseX <= button.x + button.width and mouseY >= button.y and mouseY <= button.y + button.height
    end
end

function Scene:checkButtonActions()
    for _, button in pairs(self.buttons) do
        if self:checkButtonClick(button) or (button.isSelected and love.keyboard.isDown("return")) then
            self:handleButtonClick(button)
        end
    end
end

function Scene:checkButtonClick(button)
    local mouseX, mouseY = love.mouse.getPosition()
    return love.mouse.isDown(1) and mouseX >= button.x and mouseX <= button.x + button.width and mouseY >= button.y and mouseY <= button.y + button.height
end

function Scene:handleButtonClick(button)
    if button.text == "PLAY" then
        ChangeScene("Game")
    elseif button.text == "EXIT" then
        love.event.quit()
    end
end

function Scene:drawButtons()
    for _, button in pairs(self.buttons) do
        self:drawButton(button)
    end
end

function Scene:drawButton(button)
    local baseColor = {0.5, 0.5, 0.5}
    local hoverColor = {0.3, 0.3, 0.3}

    local buttonColor = button.isHovered and hoverColor or baseColor 

    love.graphics.setColor(buttonColor)
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", button.x, button.y, button.width, button.height)

    local textX = button.x + (button.width - love.graphics.getFont():getWidth(button.text)) / 2
    local textY = button.y + (button.height - love.graphics.getFont():getHeight()) / 2

    love.graphics.print(button.text, textX, textY)
    love.graphics.setColor(1, 1, 1)
end

function Scene:handleEnterKey()
    for _, button in pairs(self.buttons) do
        if button.isHovered then
            self:handleButtonClick(button)
            return
        end
    end
end

function Scene:handleArrowKeys(direction)
    local currentIndex = self:getSelectedButtonIndex()

    if direction == "up" then
        currentIndex = currentIndex - 1
    elseif direction == "down" then
        currentIndex = currentIndex + 1
    end

    currentIndex = self:wrapIndex(currentIndex)

    self:selectButtonByIndex(currentIndex)
end

function Scene:wrapIndex(index)
    local buttonCount = #self.buttons

    if index < 1 then
        return buttonCount
    elseif index > buttonCount then
        return 1
    end

    return index
end

function Scene:selectButtonByIndex(index)
    for i, button in pairs(self.buttons) do
        button.isHovered = (i == index)
    end
end

function Scene:getSelectedButtonIndex()
    for i, button in pairs(self.buttons) do
        if button.isHovered then
            return i
        end
    end

    return 1
end

return Scene
