-- InputConfig.lua
return {
    move_left = { joystick_axis = "left_x", joystick_value = -1, key = "a", command = "move_left" },
    move_right = { joystick_axis = "left_x", joystick_value = 1, key = "d", command = "move_right" },
    jump = { joystick_button = "a", key = "space", command = "jump" },
    shoot = { mouse_button = "left", joystick_button = "x", touch = true, command = "shoot" },

    -- Mapowanie przycisków joysticka na klawisze i komendy
    joystick_to_key = {
        [1] = "shoot",  -- Przycisk 1 wywołuje polecenie "shoot"
        [2] = "jump"    -- Przycisk 2 wywołuje polecenie "jump"
    }
}
