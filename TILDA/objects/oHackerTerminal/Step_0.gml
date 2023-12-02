var result = do_element();
if (result == true)
{
	color = c_red;
	if (alarm[0] == -1) 
	{
		if(global.hackerMode) 
		{
			value = string_copy(value, 0, string_length(value) - 1) + " ";
		}
		else 
		{
			value = string_copy(value, 0, string_length(value) - 1) + "|";
		}
		alarm[0] = 30;
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
			if (string_length(value) - 1 < charLimit) value = string_copy(value, 0, string_length(value) - 1) + chr(keyboard_key) + "|";
		}
	}
	
	if (keyboard_check_pressed(vk_enter))
	{
		value = string_copy(value, 0, string_length(value) - 1) + " ";
		if (activatedFunction != undefined) activatedFunction();
		valuePrev = value;
		isActive = false;
	}
}
else
{
	color = c_white;
	value = string_copy(value, 0, string_length(value) - 1) + " ";
	value = valuePrev;
}