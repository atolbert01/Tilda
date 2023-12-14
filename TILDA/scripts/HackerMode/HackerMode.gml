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
			enter_text("USEFUL FUNCTIONS", c_white);
			enter_text("----------------\n", c_white);
			enter_text("CTRL+H - FIND TERM", debugColor);
			enter_text("\n", debugColor);
			enter_text("KNOWN COMMANDS", c_white);
			enter_text("----------------\n", c_white);
			enter_text("CLS - CLEAR SCREEN", debugColor);
			enter_text("EDIT - PLACE WALLS", debugColor);
			enter_text("RESET - UNDO ALL", debugColor);
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
			enter_text("EDITING...", c_white);
			enter_text("ENTER:  APPLY", debugColor);
			enter_text("CTRL+C:  STOP", debugColor);
			with (oHackerMode)
			{
				editMode = true;
				editState = EDIT_STATE.IDLE;
			}
			with(oRegion) visible = true;
			break;
		}
		case "RESET" :
		{
			enter_text("ALL HACKS RESET", c_white);
			reset_hacks(oPlayer);
		}
		case "WARP" :
		{
			if (array_length(tokens) < 2)
			{
				enter_text("ERROR. USAGE:", errorColor);
				enter_text("WARP <TAG>", debugColor);
			}
			else
			{
				var doWarp = false;
				var warpTag = tokens[1];
				for (var i = 0; i < instance_number(oCheckpoint); ++i;)
				{
					var checkpoint = instance_find(oCheckpoint, i);
					if (checkpoint.tag == warpTag)
					{
						doWarp = true;
						with (oPlayer)
						{
							
							// Update room bounds. Need to do this before we warp the player
							var newBounds = instance_place(checkpoint.x, checkpoint.y, oBounds);
							if (roomBounds != newBounds)
							{
								if (roomBounds != noone)
								{
									roomBounds.unpause_actors();
									roomBounds.active = false;
									roomBounds.deactivate_actors();
								}
								roomBounds = newBounds;
								roomBounds.active = true;
								roomBounds.activate_actors();
							}
							
							x = checkpoint.x;
							y = checkpoint.y;
							hackerStone.x = x;
							hackerStone.y = y - 24;
							shield.x = x;
							shield.y = y;
							
							// Update camera
							var viewWidth = camera_get_view_width(view_camera[0]);
							var viewHeight = camera_get_view_height(view_camera[0]);
							var goToX = x - (viewWidth * 0.5);
							var goToY = y - (viewHeight * 0.5);
							adjCamX = goToX;
							adjCamY = goToY;
							camera_set_view_pos(view_camera[0], round(adjCamX), round(adjCamY));
							
							set_glitch_budget(self, -10);
						}
					}
				}
				if (!doWarp)
				{
					enter_text("ERROR. UNKNOWN TAG.", errorColor);
				}
			}
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
		cursor.sprite_index = sCursor_ResizeV;
		return EDIT_STATE.RESIZE_EDGE_TOP;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.LEFT, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeH;
		return EDIT_STATE.RESIZE_EDGE_LEFT;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.BOTTOM, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2))
	{
		cursor.sprite_index = sCursor_ResizeV;
		return EDIT_STATE.RESIZE_EDGE_BOTTOM;
	}
	
	resizeZone = edge_resize_zone(region, REGION_EDGE.RIGHT, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeH;
		return EDIT_STATE.RESIZE_EDGE_RIGHT;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X1_Y1, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeDiag1;
		return EDIT_STATE.RESIZE_X1_Y1;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X2_Y1, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeDiag2;
		return EDIT_STATE.RESIZE_X2_Y1;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X2_Y2, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeDiag1;
		return EDIT_STATE.RESIZE_X2_Y2;
	}
	
	resizeZone = corner_resize_zone(region, REGION_CORNER.X1_Y2, padAmount);
	if (point_in_rectangle(cursorX, cursorY, resizeZone.x1, resizeZone.y1, resizeZone.x2, resizeZone.y2)) 
	{
		cursor.sprite_index = sCursor_ResizeDiag2;
		return EDIT_STATE.RESIZE_X1_Y2;
	}
	cursor.sprite_index = sCursor;
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

function set_glitch_budget(player, amount)
{
	player.glitchBudget = clamp(player.glitchBudget + amount, 0, 100);
}

function glitch_intensity(player)
{
	//return min(((100 / player.glitchBudget) - 1) * 0.025, 0.5);
	if (!instance_exists(oHackerStone)) return 0; // Only glitch if we have found the stone
	var budget = player.glitchBudget;
	if (budget > 75)
	{
		return 0.01;
	}
	if (budget < 75 && budget > 50)
	{
		return 0.025;
	}
	if (budget < 50 && budget > 25)
	{
		return 0.05;
	}
	if (budget < 25 && budget >= 0)
	{
		return 0.08;
	}
}

function reset_hacks(player)
{
	with (oGlitchWall)
	{
		instance_destroy(self);
	}
	with (oRegion)
	{
		instance_destroy(self);
	}
	set_glitch_budget(player, 100);
}

function activate_hackerstone(player)
{
	instance_activate_object(player.hackerStone);
	player.hackerMode.active = true;
	player.glitchBudget = 100;
}

function activate_shield(player)
{
	instance_activate_object(player.shield);
	player.shieldStrength = 100;
}