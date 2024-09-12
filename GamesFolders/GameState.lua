local Class = require 'hump.class'
local BaseState = require 'BaseState'

local GameState = Class{__includes = BaseState}

function GameState:init()
    BaseState.init(self, "GameState")  -- Inicjalizacja z nazwą stanu
end

function GameState:enter()
    BaseState.enter(self)
    -- Logika stanu gry przy wchodzeniu
end

function GameState:update(dt)
    BaseState.update(self, dt)
    -- Logika gry, np. poruszanie obiektów
end

function GameState:draw()
    BaseState.draw(self)
    -- Rysowanie elementów gry
    love.graphics.print("Witaj w GameState!", 100, 100)
end

function GameState:keypressed(key)
    BaseState.keypressed(self, key)
    
    -- Obsługa wciśnięcia klawiszy specyficzna dla GameState
    if key == "space" then
        print("Naciśnięto spację w GameState!")
    end
end

return GameState
