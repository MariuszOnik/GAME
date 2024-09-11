local Class = require 'hump.class'    -- Biblioteka do tworzenia klas
local Signal = require 'hump.signal'  -- Biblioteka do zarządzania sygnałami

local InputManager = Class{}

function InputManager:init()
    -- Pozycja kursora symulowanego za pomocą joysticka
    self.cursorX, self.cursorY = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    self.cursorSpeed = 300  -- Prędkość poruszania kursorem za pomocą joysticka
end

-- Aktualizacja pozycji kursora i obsługa joysticka
function InputManager:update(dt)
    local joysticks = love.joystick.getJoysticks()
    
    if #joysticks > 0 then
        local joystick = joysticks[1] -- Używamy pierwszego dostępnego joysticka
        local axisX = joystick:getAxis(1)  -- Lewa gałka: oś X
        local axisY = joystick:getAxis(2)  -- Lewa gałka: oś Y
        
        -- Symulacja ruchu kursora za pomocą gałek analogowych
        self.cursorX = self.cursorX + axisX * self.cursorSpeed * dt
        self.cursorY = self.cursorY + axisY * self.cursorSpeed * dt
        
        -- Upewnij się, że kursor nie wychodzi poza ekran
        self.cursorX = math.max(0, math.min(self.cursorX, love.graphics.getWidth()))
        self.cursorY = math.max(0, math.min(self.cursorY, love.graphics.getHeight()))
        
        -- Emituj sygnał o ruchu kursora
        Signal.emit("cursor_moved", self.cursorX, self.cursorY)
    end
end

-- Obsługa kliknięcia myszką
function InputManager:mousepressed(x, y, button)
    -- Emituj sygnał o kliknięciu myszą
    Signal.emit("button_pressed", x, y, button)
end

-- Obsługa kliknięcia joystickiem
function InputManager:joystickpressed(joystick, button)
    -- Emituj sygnał o kliknięciu joystickiem
    Signal.emit("button_pressed", self.cursorX, self.cursorY, button)
end

-- Obsługa dotyku
function InputManager:touchpressed(id, x, y, dx, dy, pressure)
    -- Emituj sygnał o dotyku
    Signal.emit("button_pressed", x, y, 1)  -- Symulujemy kliknięcie lewym przyciskiem
end

return InputManager