local Class = require 'hump.class'

local CommandManager = Class{}

function CommandManager:init()
    self.commands = {}  -- Lista wszystkich poleceń
end

-- Rejestrowanie nowego polecenia
function CommandManager:addCommand(command)
    table.insert(self.commands, command)
end

-- Wykonywanie wszystkich poleceń
function CommandManager:execute()
    for _, command in ipairs(self.commands) do
        command:execute()
    end
end

-- Cofanie wszystkich poleceń
function CommandManager:undo()
    for _, command in ipairs(self.commands) do
        if command.undo then
            command:undo()
        end
    end
end

return CommandManager
