local Class = require 'hump.class'
local BaseState = require 'source.BaseState'

local GameState = Class{__includes = BaseState}

function GameState:init()
    -- Inicjalizacja stanu i załadowanie konfiguracji
    BaseState.init(self, "GameState")
end

function GameState:enter()
    BaseState.enter(self)
    -- Logika specyficzna dla GameState
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

return GameState
