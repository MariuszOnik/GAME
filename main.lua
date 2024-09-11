local InputManager = require 'src.InputManager'  -- Ładujemy InputManager z folderu 'source'
local Signal = require 'hump.signal'

local inputManager = InputManager()  -- Tworzymy instancję Menadżera wejścia

-- Testowe zmienne, aby śledzić ruch kursora i kliknięcia
local cursorX, cursorY = 0, 0
local lastClickX, lastClickY, lastButton = nil, nil, nil

-- Funkcja obsługująca ruch kursora
Signal.register("cursor_moved", function(x, y)
    cursorX, cursorY = x, y  -- Aktualizacja położenia kursora
    print("Kursor przesunięty na: ", x, y)
end)

-- Funkcja obsługująca kliknięcia
Signal.register("button_pressed", function(x, y, button)
    lastClickX, lastClickY, lastButton = x, y, button
    print("Kliknięto w pozycji: ", x, y, " przycisk: ", button)
end)

-- Obsługa przesunięcia dotyku
function love.touchmoved(id, x, y, dx, dy, pressure)
    inputManager:touchmoved(id, x, y, dx, dy, pressure)  -- Emitujemy sygnał o przesunięciu dotyku
end

-- Obsługa zakończenia dotyku
function love.touchreleased(id, x, y, dx, dy, pressure)
    inputManager:touchreleased(id, x, y, dx, dy, pressure)  -- Emitujemy sygnał o zakończeniu dotyku
end

-- Nasłuchiwanie na sygnały
Signal.register("touch_moved", function(x, y, dx, dy)
    print("Przesunięto dotyk na: " .. x .. ", " .. y .. " przesunięcie: " .. dx .. ", " .. dy)
end)

Signal.register("touch_released", function(x, y)
    print("Dotyk zakończony w: " .. x .. ", " .. y)
end)

-- Aktualizacja gry
function love.update(dt)
    inputManager:update(dt)  -- Aktualizacja pozycji kursora symulowanego za pomocą joysticka
end

-- Obsługa kliknięcia myszką
function love.mousepressed(x, y, button)
    inputManager:mousepressed(x, y, button)  -- Emitujemy sygnał o kliknięciu myszą
end

-- Obsługa kliknięcia przyciskami joysticka
function love.joystickpressed(joystick, button)
    inputManager:joystickpressed(joystick, button)  -- Emitujemy sygnał o kliknięciu joystickiem
end

-- Obsługa dotyku (zasymulowana na PC jako kliknięcie myszą)
function love.touchpressed(id, x, y, dx, dy, pressure)
    inputManager:touchpressed(id, x, y, dx, dy, pressure)  -- Emitujemy sygnał o dotknięciu ekranu
end

-- Rysowanie stanu testowego (położenie kursora i ostatnie kliknięcie)
function love.draw()
    love.graphics.print("Pozycja kursora: (" .. cursorX .. ", " .. cursorY .. ")", 10, 10)

    if lastClickX and lastClickY then
        love.graphics.print("Ostatnie kliknięcie: (" .. lastClickX .. ", " .. lastClickY .. ") przycisk: " .. lastButton, 10, 30)
    end
end
