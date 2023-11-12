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
    self.m_buttons = {}
    self:createButtons()
    self.m_menuFont = love.graphics.newFont("src/Fonts/Storm Gust.ttf", MENU_FONT_SIZE)
    self.m_backgroundImage = love.graphics.newImage("src/Textures/Background/otroFondo.png")
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
    love.graphics.draw(self.m_backgroundImage, 0, 0, 0, love.graphics.getWidth() / self.m_backgroundImage:getWidth(), love.graphics.getHeight() / self.m_backgroundImage:getHeight())
end

function Scene:drawTitle()
    local l_title = "C H A O S   S T O R M"
    local l_titleX = (love.graphics.getWidth() - self.m_menuFont:getWidth(l_title)) / 2
    local l_titleY = TITLE_Y

    love.graphics.setFont(self.m_menuFont)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(l_title, l_titleX + 5, l_titleY + 5)
    love.graphics.print(l_title, l_titleX - 5, l_titleY - 5)
    love.graphics.setColor(1, 0.1, 0.2)
    love.graphics.print(l_title, l_titleX, l_titleY)
    love.graphics.setFont(love.graphics.newFont())
end

function Scene:createButtons()
    self.m_buttons.play = self:createButton("PLAY", 1)
    self.m_buttons.quit = self:createButton("EXIT", 2)
end

function Scene:createButton(text, index)
    local l_position = self:calculateButtonPosition(index)

    return {
        x = l_position.x,
        y = l_position.y,
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
    for _, l_button in pairs(self.m_buttons) do
        local l_mouseX, l_mouseY = love.mouse.getPosition()
        l_button.isHovered = l_mouseX >= l_button.x and l_mouseX <= l_button.x + l_button.width and l_mouseY >= l_button.y and l_mouseY <= l_button.y + l_button.height
    end
end

function Scene:checkButtonActions()
    for _, l_button in pairs(self.m_buttons) do
        if self:checkButtonClick(l_button) or (l_button.isSelected and love.keyboard.isDown("return")) then
            self:handleButtonClick(l_button)
        end
    end
end

function Scene:checkButtonClick(l_button)
    local l_mouseX, l_mouseY = love.mouse.getPosition()
    return love.mouse.isDown(1) and l_mouseX >= l_button.x and l_mouseX <= l_button.x + l_button.width and l_mouseY >= l_button.y and l_mouseY <= l_button.y + l_button.height
end

function Scene:handleButtonClick(l_button)
    if l_button.text == "PLAY" then
        ChangeScene("Game")
    elseif l_button.text == "EXIT" then
        love.event.quit()
    end
end

function Scene:drawButtons()
    for _, l_button in pairs(self.m_buttons) do
        self:drawButton(l_button)
    end
end

function Scene:drawButton(l_button)
    local l_baseColor = {0.5, 0.5, 0.5}
    local l_hoverColor = {0.3, 0.3, 0.3}

    local l_buttonColor = l_button.isHovered and l_hoverColor or l_baseColor 

    love.graphics.setColor(l_buttonColor)
    love.graphics.rectangle("fill", l_button.x, l_button.y, l_button.width, l_button.height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", l_button.x, l_button.y, l_button.width, l_button.height)

    local l_textX = l_button.x + (l_button.width - love.graphics.getFont():getWidth(l_button.text)) / 2
    local l_textY = l_button.y + (l_button.height - love.graphics.getFont():getHeight()) / 2

    love.graphics.print(l_button.text, l_textX, l_textY)
    love.graphics.setColor(1, 1, 1)
end

function Scene:handleEnterKey()
    for _, l_button in pairs(self.m_buttons) do
        if l_button.isHovered then
            self:handleButtonClick(l_button)
            return
        end
    end
end

function Scene:handleArrowKeys(direction)
    local l_currentIndex = self:getSelectedButtonIndex()

    if direction == "up" then
        l_currentIndex = l_currentIndex - 1
    elseif direction == "down" then
        l_currentIndex = l_currentIndex + 1
    end

    l_currentIndex = self:wrapIndex(l_currentIndex)

    self:selectButtonByIndex(l_currentIndex)
end

function Scene:wrapIndex(index)
    local l_buttonCount = #self.m_buttons

    if index < 1 then
        return l_buttonCount
    elseif index > l_buttonCount then
        return 1
    end

    return index
end

function Scene:selectButtonByIndex(index)
    for i, l_button in pairs(self.m_buttons) do
        l_button.isHovered = (i == index)
    end
end

function Scene:getSelectedButtonIndex()
    for i, l_button in pairs(self.m_buttons) do
        if l_button.isHovered then
            return i
        end
    end

    return 1
end

return Scene
