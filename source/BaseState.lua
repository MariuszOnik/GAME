local Class = require 'hump.class'
local Gamestate = require 'hump.gamestate'
local Signal = require 'hump.signal'
local CommandManager = require 'source.CommandManager'

local BaseState = Class{}

function BaseState:init(stateName)
    self.stateName = stateName
    self.config = self:loadConfig(stateName)
    
    -- Tworzymy menadżera poleceń
    self.commandManager = CommandManager()

    -- Rejestrujemy sygnał nasłuchujący na przyciski
    Signal.register('key_pressed', function(key) self:onKeyPressed(key) end)
    Signal.register('joystick_pressed', function(joystick, button) self:onJoystickPressed(joystick, button) end)
end

function BaseState:enter()
    -- Logika po wejściu w stan, można dodać specyficzną logikę w każdym stanie
end

function BaseState:update(dt)
    -- Aktualizacja logiki dla stanu, można rozszerzać w stanie
end

function BaseState:draw()
    -- Rysowanie elementów stanu
end

function BaseState:onKeyPressed(key)
    -- Sprawdzamy, czy klawisz z pliku konfiguracyjnego służy do powrotu do MenuState
    if key == self.config.backToMenuKey then
        self:executeBackToMenu()
    end
end

function BaseState:onJoystickPressed(joystick, button)
    -- Sprawdzamy, czy przycisk z pliku konfiguracyjnego służy do powrotu do MenuState
    if button == self.config.backToMenuJoystickButton then
        self:executeBackToMenu()
    end
end

function BaseState:executeBackToMenu()
    -- Tworzymy polecenie powrotu do MenuState
    local command = {
        execute = function()
            local MenuState = require 'GamesFolders.MenuState'
            Gamestate.switch(MenuState)
        end,
        undo = function()
            -- Logika cofnięcia powrotu do MenuState (opcjonalna)
        end
    }
    self.commandManager:executeCommand(command)
end

-- Funkcja do ładowania pliku konfiguracyjnego
function BaseState:loadConfig(stateName)
    local configPath = "configs/" .. stateName .. "Config.lua"
    
    if not love.filesystem.getInfo(configPath) then
        -- Tworzymy domyślny plik konfiguracyjny, jeśli nie istnieje
        local defaultConfig = "-- Domyślny plik konfiguracyjny dla " .. stateName .. "\nreturn {backToMenuKey = 'escape', backToMenuJoystickButton = 11}"
        love.filesystem.write(configPath, defaultConfig)
    end
    
    -- Wczytujemy plik konfiguracyjny
    local config = require("configs." .. stateName .. "Config")
    return config
end

return BaseState
