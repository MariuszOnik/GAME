local Class = require 'hump.class'
local Signal = require 'hump.signal'
local InputConfig = require 'InputConfig'
local CommandManager = require 'CommandManager'

local InputManager = Class{}

function InputManager:init()
    -- Ładowanie konfiguracji wejść
    self.config = InputConfig
    self.cursorX, self.cursorY = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    self.cursorSpeed = 300

    -- Sprawdzanie dostępnych urządzeń
    self.joystickConnected = love.joystick.getJoystickCount() > 0
    self.mouseConnected = love.mouse.isDown(1)  -- Sprawdzamy, czy mysz jest dostępna
end

function InputManager:update(dt)
    -- Obsługa ruchu joysticka
    if self.joystickConnected then
        local joysticks = love.joystick.getJoysticks()
        local joystick = joysticks[1]
        local axisX = joystick:getAxis(1)

        -- Ruch joysticka i przypisane komendy
        if axisX < -0.5 then
            CommandManager.executeCommand(self.config.move_left.command)
        elseif axisX > 0.5 then
            CommandManager.executeCommand(self.config.move_right.command)
        end
    else
        -- Obsługa klawiatury
        if love.keyboard.isDown(self.config.move_left.key) then
            CommandManager.executeCommand(self.config.move_left.command)
        elseif love.keyboard.isDown(self.config.move_right.key) then
            CommandManager.executeCommand(self.config.move_right.command)
        end
    end
end

-- Obsługa kliknięcia joystickiem
function InputManager:joystickpressed(joystick, button)
    local command = self.config.joystick_to_key[button]
    if command then
        CommandManager.executeCommand(command)
    else
        CommandManager.executeCommand("shoot")  -- Przykładowa domyślna komenda
    end
end

-- Obsługa naciśnięcia klawisza
function InputManager:keypressed(key)
    CommandManager.executeCommand("key_pressed", key)
end

-- Obsługa kliknięcia myszą
function InputManager:mousepressed(x, y, button)
    local command = self.config.mouse_button_to_command[button]
    if command then
        CommandManager.executeCommand(command)
    end
end

-- Obsługa dotyku (np. na Switchu)
function InputManager:touchpressed(id, x, y, dx, dy, pressure)
    CommandManager.executeCommand("touch", x, y)
end

return InputManager
