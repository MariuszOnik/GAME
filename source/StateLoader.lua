local StateLoader = {}

function StateLoader.loadState(stateName)
    local statePath = "GamesFolders." .. stateName
    local state = require(statePath)
    return state
end

return StateLoader
