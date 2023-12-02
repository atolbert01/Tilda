function show_hide_panel(panel)
{
	// Set drawMe before calling
	panel.drawMe = !panel.drawMe;
	for (var i = 0; i < array_length(panel.subElements); i++)
	{
		var e = panel.subElements[i];
		e.drawMe = panel.drawMe;
		e.enabled = e.drawMe;
	}
}

function do_element()
{
	var cursorX = device_mouse_x_to_gui(0);
	var cursorY = device_mouse_y_to_gui(0);

	isHot = false;
	if (point_in_rectangle(cursorX, cursorY, boundsX1, boundsY1, boundsX2, boundsY2))
	{
		isHot = true;
	}

	if (isActive)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			if (isHot) return true;
			isActive = false;
		}
	}
	else if (isHot)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			isActive = true;
			show_debug_message("Click!");
		}
	}
	return isActive;
}