local Gamestate = require 'hump.gamestate'
local MenuState = require 'MenuState'

function love.load()
    -- Ustawienie początkowego stanu na MenuState
    Gamestate.registerEvents()
    Gamestate.switch(MenuState)
end
