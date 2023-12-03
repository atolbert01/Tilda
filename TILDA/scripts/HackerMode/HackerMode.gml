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
		// While we're here, let's find out if the mouse button is held (useful for dragging elements)
		if (!isDragging && mouse_check_button(mb_left))
		{
			isDragging = true;
			grabOffsetX = cursorX - x;
			grabOffsetY = cursorY - y;
		}
	}

	if (!isHot && isActive)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			isActive = false;
		}
	}
	else if (isHot)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			isActive = true;
		}
	}
	
	if (isDragging)
	{
		x = cursorX - grabOffsetX;
		y = cursorY - grabOffsetY;
	
		boundsX1 = x;
		boundsY1 = y;
		boundsX2 = x + boundsWidth;
		boundsY2 = y + boundsHeight;
	}
	
	if (isDragging && mouse_check_button_released(mb_left)) isDragging = false;
	
	return isActive;
}