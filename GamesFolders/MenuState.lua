local Class = require 'hump.class'
local Gamestate = require 'hump.gamestate'
local StateLoader = require 'source.StateLoader'    -- Ścieżka do StateLoader
local StateConfig = require 'StateConfig'           -- Ścieżka do StateConfig
local BaseState = require 'source.BaseState'        -- Ścieżka do BaseState

local MenuState = Class{__includes = BaseState}

function MenuState:init()
    -- Inicjalizacja z BaseState, wczytanie konfiguracji
    BaseState.init(self, "MenuState")
    
    -- Wczytanie stanów z pliku konfiguracyjnego
    self.states = StateConfig.states
    self.selectedState = 1
end

function MenuState:update(dt)
    -- Logika aktualizacji dla MenuState
end

function MenuState:draw()
    -- Rysowanie menu wyboru stanów
    love.graphics.print("Wybierz stan do uruchomienia:", 100, 100)
    for i, state in ipairs(self.states) do
        local prefix = (i == self.selectedState) and "> " or "  "
        love.graphics.print(prefix .. state.name, 100, 120 + (i - 1) * 20)
    end
end

function MenuState:keypressed(key)
    if key == "up" then
        self.selectedState = math.max(1, self.selectedState - 1)
    elseif key == "down" then
        self.selectedState = math.min(#self.states, self.selectedState + 1)
    elseif key == "return" then
        -- Przełączenie do wybranego stanu
        local selectedStateName = self.states[self.selectedState].name
        Gamestate.switch(StateLoader.loadState(selectedStateName))
    end
end

return MenuState
