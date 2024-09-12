local Class = require 'hump.class'

local CommandManager = Class{}

function CommandManager:init()
    self.commands = {}
end

function CommandManager:executeCommand(command)
    table.insert(self.commands, command)
    command:execute()
end

function CommandManager:undo()
    local command = table.remove(self.commands)
    if command then
        command:undo()
    end
end

return CommandManager
