local StateConfig = require 'StateConfig'

local StateLoader = {}

-- Leniwe ładowanie stanów na podstawie konfiguracji
function StateLoader.loadState(stateName)
    -- Szukamy stanu w konfiguracji
    for _, state in ipairs(StateConfig.states) do
        if state.name == stateName then
            if not state.loaded then
                -- Ładujemy stan dopiero, gdy jest potrzebny
                state.state = require(state.path)
                state.loaded = true
                print("Stan " .. stateName .. " został załadowany.")
            end
            return state.state
        end
    end
    print("Stan " .. stateName .. " nie został znaleziony.")
    return nil
end

return StateLoader
