var result = do_element();
if (result == true)
{
	if (alarm[0] == -1) alarm[0] = 30;
	
	var scrollDown = mouse_wheel_down() || keyboard_check_pressed(vk_down) || gamepad_axis_value(0, gp_axislv) > 0.3 || gamepad_button_check(0, gp_padd);
	var scrollUp = mouse_wheel_up() || keyboard_check_pressed(vk_up) || gamepad_axis_value(0, gp_axislv) < -0.3 || gamepad_button_check(0, gp_padu);
	var ctrlDown = keyboard_check(vk_control);
	
	if (scrollDown)
	{
		scrollOffset = min(breakHeight * cursorRow, scrollOffset + 8);
	}
	
	if (scrollUp)
	{
		scrollOffset = max(0, scrollOffset - 8);
	}
	
	if (ctrlDown)
	{
		if (keyboard_check_pressed(ord("H")))
		{
			x = startX;
			y = startY;
		
			boundsX1 = x;
			boundsY1 = y;
			boundsX2 = x + boundsWidth;
			boundsY2 = y + boundsHeight;
		}
		
		if (keyboard_check_pressed(ord("C")))
		{
			if (oHackerMode.editMode)
			{
				with (oHackerMode)
				{
					exit_edit_mode();
				}
				enter_text("^C", debugColor);
				enter_text("EDIT OFF", debugColor);
			}
		}
	}

	if (keyboard_check_pressed(vk_backspace))
	{
		value = string_copy(value, 0, string_length(value) - 1);
	}
	else if (!ctrlDown && keyboard_check_pressed(vk_anykey))
	{
		var enabledKeys = "";
		if (allowLetters) enabledKeys += enabledLetters;
		if (allowNumbers) enabledKeys += enabledNumbers;
		
		if ((string_count(chr(keyboard_key), enabledKeys)) && string_length(chr(keyboard_key)) == 1)
		{
			if (string_length(value) < charLimit) 
				value = string_copy(value, 0, string_length(value)) + chr(keyboard_key);
		}
		
		if (cursorRow * breakHeight > (scrollOffset - (breakHeight * 2)) + (boundsY2 - boundsY1)) 
		{
			scrollOffset = (breakHeight * cursorRow) - 64; // TODO: got a magic number here to describe the terminal height
		}
	}
	if (keyboard_check_pressed(vk_enter))
	{
		if (activatedFunction != undefined) activatedFunction();
		
		alarm[0] = -1;
		cursorVisible = false
		valuePrev = value;
		value = "";
		
		enter_text(valuePrev, inactiveColor);
		
		//ds_list_add(textHistory, { text : valuePrev, color : inactiveColor });
		//cursorRow += 1;
		//if (cursorRow * breakHeight > (scrollOffset - (breakHeight * 2)) + (boundsY2 - boundsY1)) 
		//{
		//	scrollOffset = (breakHeight * cursorRow) - 64; // TODO: got a magic number here to describe the terminal height
		//}
		
		var input = string_trim(valuePrev);
		if (input != "") process_input(input);
	}
}