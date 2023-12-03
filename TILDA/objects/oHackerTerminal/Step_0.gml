var result = do_element();
if (result == true)
{
	if (alarm[0] == -1) alarm[0] = 30;
	
	var keyDown = keyboard_check(vk_down) || gamepad_axis_value(0, gp_axislv) > 0.3 || gamepad_button_check(0, gp_padd);
	var keyUp = keyboard_check(vk_up) || gamepad_axis_value(0, gp_axislv) < -0.3 || gamepad_button_check(0, gp_padu);
	
	if (keyUp)
	{
		scrollY += 8;
		show_debug_message("Up: " + string(scrollY));
	}
	
	if (keyDown)
	{
		scrollY -= 8;
		show_debug_message("Down: " + string(scrollY));
	}
	
	if (keyboard_check_pressed(vk_backspace))
	{
		value = string_copy(value, 0, string_length(value) - 1);
	}
	else if (keyboard_check_pressed(vk_anykey))
	{
		var enabledKeys = "";
		if (allowLetters) enabledKeys += enabledLetters;
		if (allowNumbers) enabledKeys += enabledNumbers;
		
		if ((string_count(chr(keyboard_key), enabledKeys)) && string_length(chr(keyboard_key)) == 1)
		{
			if (string_length(value) < charLimit) 
				value = string_copy(value, 0, string_length(value)) + chr(keyboard_key);
		}
	}
	if (keyboard_check_pressed(vk_enter))
	{
		if (activatedFunction != undefined) activatedFunction();
		
		alarm[0] = -1;
		cursorVisible = false
		valuePrev = value;
		value = "";
		ds_list_add(textHistory, valuePrev);
		cursorRow += 1;
	}
}