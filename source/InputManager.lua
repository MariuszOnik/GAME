local Class = require 'hump.class'
local Signal = require 'hump.signal'  -- System sygnałów

local InputManager = Class{}

function InputManager:init()
    -- Inicjalizacja kursora i innych ustawień
    self.cursorX, self.cursorY = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    self.cursorSpeed = 300  -- Prędkość poruszania kursorem
end

function InputManager:update(dt)
    -- Obsługa joysticka, myszy, dotyku itp. i wysyłanie sygnałów
end

function InputManager:keypressed(key)
    -- Emitujemy sygnał, aby system mógł odpowiedzieć na klawisze
    Signal.emit('key_pressed', key)
end

function InputManager:mousepressed(x, y, button)
    -- Obsługa kliknięcia myszką
    Signal.emit('button_pressed', x, y, button)
end

function InputManager:joystickpressed(joystick, button)
    Signal.emit('joystick_pressed', joystick, button)
end


-- Obsługa innych urządzeń wejściowych, np. joysticków

return InputManager
