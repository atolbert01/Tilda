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

function enter_text(input, newColor)
{
	ds_list_add(textHistory, { text : input, color : newColor });
	cursorRow += 1;
	if (cursorRow * breakHeight > (scrollOffset - (breakHeight * 2)) + (boundsY2 - boundsY1)) 
	{
		scrollOffset = (breakHeight * cursorRow) - 64; // TODO: got a magic number here to describe the terminal height
	}
}

function process_input(input)
{ 
	var tokens = string_split(input," ");
	switch(tokens[0])
	{
		case "HELP" :
		{
			enter_text("USEFUL FUNCTIONS", debugColor);
			enter_text("----------------\n", debugColor);
			enter_text("CTRL+H - FIND TERM", debugColor);
			enter_text("\n", debugColor);
			enter_text("KNOWN COMMANDS", debugColor);
			enter_text("----------------\n", debugColor);
			enter_text("CLS - CLEAR SCREEN", debugColor);
			enter_text("EDIT - PLACE WALLS", debugColor);
			enter_text("???? - ????", debugColor);
			enter_text("???? - ????", debugColor);
			enter_text("???? - ????", debugColor);
			enter_text("???? - ????", debugColor);
			break;
		}
		case "CLS" :
		{
			ds_list_clear(textHistory);
			scrollOffset = 0;
			cursorRow = 0;
			break;
		}
		case "EDIT" :
		{
			enter_text("EDITING...", debugColor);
			enter_text("CTRL + C TO STOP...", debugColor);
			with (oHackerMode)
			{
				editMode = true;
				editState = EDIT_STATE.IDLE;
			}
			with(oRegion) visible = true;
			break;
		}
		
		default  :
		{
			
			break;
		}
		
	}
}

/// Returns the appropriate EDIT_STATE if the cursor is inside a resize zone. Sets the cursor.
function cursor_in_resize_zone(cursorX, cursorY, region, padAmount)
{
	var resizeZone = edge_resize_zone(region, REGION_EDGE.TOP, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeV;
		return EDIT_STATE.RESIZE_EDGE_TOP;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.LEFT, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeH;
		return EDIT_STATE.RESIZE_EDGE_LEFT;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.BOTTOM, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2))
	{
		cursorSprite = sCursor_ResizeV;
		return EDIT_STATE.RESIZE_EDGE_BOTTOM;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.RIGHT, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeH;
		return EDIT_STATE.RESIZE_EDGE_RIGHT;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X1_Y1, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeDiag1;
		return EDIT_STATE.RESIZE_X1_Y1;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X2_Y1, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeDiag2;
		return EDIT_STATE.RESIZE_X2_Y1;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X2_Y2, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeDiag1;
		return EDIT_STATE.RESIZE_X2_Y2;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X1_Y2, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursorSprite = sCursor_ResizeDiag2;
		return EDIT_STATE.RESIZE_X1_Y2;
	}
	cursorSprite = sCursor;
	return -1;
}

function edge_resize_zone(region, edge, padAmount)
{
	switch edge
	{
		case REGION_EDGE.TOP :
		{
			return {x1 : region.x + padAmount, y1 : region.y - padAmount, x2 : region.x + region.width - padAmount, y2 : region.y + padAmount };
		}
		case REGION_EDGE.LEFT :
		{
			return {x1 : region.x - padAmount, y1 : region.y + padAmount, x2 : region.x + padAmount, y2 : region.y + region.height - padAmount };
		}
		case REGION_EDGE.BOTTOM :
		{
			return {x1 : region.x + padAmount, y1 : region.y + region.height - padAmount, x2 : region.x + region.width - padAmount, y2 : region.y + region.height + padAmount };
		}
		case REGION_EDGE.RIGHT :
		{
			return {x1 : region.x + region.width - padAmount, y1 : region.y + padAmount, x2 : region.x + region.width + padAmount, y2 : region.y + region.height - padAmount };
		}	
	}
	return { x1 : 0, y1 : 0, x2 : 0, y2 : 0 };
}

function corner_resize_zone(region, corner, padAmount)
{
	switch corner
	{
		case REGION_CORNER.X1_Y1 :
		{
			return { x1 : region.x - padAmount, y1 : region.y - padAmount, x2 : region.x + padAmount, y2 : region.y + padAmount };
		}
		case REGION_CORNER.X2_Y1 :
		{
			return { x1 : region.x + region.width - padAmount, y1 : region.y - padAmount, x2 : region.x + region.width + padAmount, y2 : region.y + padAmount };
		}
		case REGION_CORNER.X2_Y2 :
		{
			return { x1 : region.x + region.width - padAmount, y1 : region.y + region.height - padAmount, x2 : region.x + region.width + padAmount, y2 : region.y + region.height + padAmount };
		}
		case REGION_CORNER.X1_Y2 :
		{
			return { x1 : region.x - padAmount, y1 : region.y + region.height - padAmount, x2 : region.x + padAmount, y2 : region.y + region.height + padAmount };
		}
	}
	return { x1 : 0, y1 : 0, x2 : 0, y2 : 0 };
}