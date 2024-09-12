local Class = require 'hump.class'
local InputManager = require 'src.InputManager'

local BaseState = Class{}

function BaseState:init()
    self.inputManager = InputManager()  -- Menadżer wejścia w każdym stanie
end

function BaseState:enter()
    -- Logika wejścia do stanu (do nadpisania w podklasach)
end

-- Obsługa aktualizacji stanu
function BaseState:update(dt)
    self.inputManager:update(dt)  -- Automatyczna obsługa wejść w każdym stanie
end

-- Obsługa kliknięć myszką
function BaseState:mousepressed(x, y, button)
    self.inputManager:mousepressed(x, y, button)
end

-- Obsługa kliknięć joystickiem
function BaseState:joystickpressed(joystick, button)
    self.inputManager:joystickpressed(joystick, button)
end

-- Obsługa dotyku
function BaseState:touchpressed(id, x, y, dx, dy, pressure)
    self.inputManager:touchpressed(id, x, y, dx, dy, pressure)
end

return BaseState
