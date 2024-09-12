local Class = require 'hump.class'
local Gamestate = require 'hump.gamestate'
local StateLoader = require 'StateLoader'
local StateConfig = require 'StateConfig'
local BaseState = require 'BaseState'

local MenuState = Class{__includes = BaseState}

function MenuState:init()
    BaseState.init(self, "MenuState")
    
    -- Wczytanie stanów z pliku konfiguracyjnego
    self.states = StateConfig.states
    self.selectedState = 1
    
    -- Sprawdzanie i tworzenie plików konfiguracyjnych (jeśli potrzeba)
    self:checkAndCreateConfigs()
end

function MenuState:update(dt)
    -- Aktualizacje logiki menu
    -- Możemy dodać tutaj dodatkową logikę, jeśli potrzebna
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

-- Funkcja sprawdzająca i tworząca pliki konfiguracyjne, jeśli nie istnieją
function MenuState:checkAndCreateConfigs()
    for _, state in ipairs(self.states) do
        local configPath = StateConfig.configFolder .. "/" .. state.name .. "Config.lua"
        
        if not love.filesystem.getInfo(configPath) then
            local defaultConfig = "-- Domyślny plik konfiguracyjny dla " .. state.name .. "\nreturn {}"
            love.filesystem.write(configPath, defaultConfig)
            print("Utworzono domyślny plik konfiguracyjny: " .. configPath)
        end
    end
end

return MenuState
