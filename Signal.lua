-- Signal.lua
-- Korzystamy z biblioteki HUMP Signal, która zarządza systemem sygnałów.
-- Sygnały są używane do luźnej komunikacji między komponentami bez ścisłego powiązania.

local Signal = require 'hump.signal'

-- Funkcje Signal: 
-- Signal.emit() - Emituje sygnał o określonej nazwie (np. "move_left").
-- Signal.register() - Rejestruje funkcję, która ma reagować na dany sygnał.

return Signal
