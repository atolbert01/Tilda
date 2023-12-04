// 192 is the tilde key. Consider allowing this to be swappable -- maybe with tab.
var toggleHackerMode = keyboard_check_pressed(192) || keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(0, gp_select);

if (toggleHackerMode) event_user(0);

if (global.hackerMode)
{
	if (editMode)
	{	
		var cursorX = mouse_x;
		var cursorY = mouse_y;
		var legalCoords = cursorX > 0 && cursorX < room_width && cursorY > 0 && cursorY < room_height && !point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), terminalPanel.boundsX1, terminalPanel.boundsY1, terminalPanel.boundsX2, terminalPanel.boundsY2);
		var xx = clamp(round(cursorX / GRID_SIZE), 0, gridWidth - 1);
		var yy = clamp(round(cursorY / GRID_SIZE), 0, gridHeight - 1);
	
		switch (editState)
		{
			case EDIT_STATE.IDLE :
			{
				if (legalCoords)
				{
					var resizeState = -1;
					var regionToCheck = noone;
					for (var i = 0; i < instance_number(oRegion); i++;)
					{
						regionToCheck = instance_find(oRegion, i);
						resizeState = cursor_in_resize_zone(cursorX, cursorY, regionToCheck, padAmount);
					
						// If we found a region, break out of the loop
						if (resizeState > -1 && regionToCheck != noone) break;
					}
				
					if (mouse_check_button_pressed(mb_left))
					{
						if (resizeState > -1 && regionToCheck != noone)
						{
							grabbedRegion = regionToCheck;
							grabbedRegion.isSelected = true;
							grabbedX = xx;
							grabbedY = yy;
							editState = resizeState;
						}
						else
						{
							var regionX = xx * GRID_SIZE;
							var regionY = yy * GRID_SIZE;
							var regionX2 = regionX + regionWidth;
							var regionY2 = regionY + regionHeight;
				
							var colCursor = false;
							var colRegion = false;
							var newGrabbedRegion = noone;
				
							with (oRegion)
							{
								if (point_in_rectangle(cursorX, cursorY, x, y, x + width, y + height))
								{
									colCursor = true;
									colRegion = true;
									newGrabbedRegion = self;
								}
								else if (rectangle_in_rectangle(x, y, x + width, y + height, regionX, regionY, regionX2, regionY2) != 0)
								{
									colRegion = true;
								}
							}
							if (colCursor && newGrabbedRegion != noone)
							{
								editState = EDIT_STATE.REGION_GRABBED
								grabbedRegion = newGrabbedRegion;
								grabbedRegion.isSelected = true;
								grabbedX = xx;
								grabbedY = yy;
								cursorSprite = sCursor_Mover;
							}
							else if (!colRegion) // No collision, so place a new region
							{
								var newRegion = instance_create_layer(regionX, regionY, "HackerMode", oRegion);
								show_debug_message("Region created");
							}	
						}
					}
					
					// Delete region if we right clicked on one
					if (mouse_check_button_pressed(mb_right))
					{
						var targetRegion = noone;
						
						with (oRegion)
						{
							if (point_in_rectangle(cursorX, cursorY, x, y, x + width, y + height))
							{
								targetRegion = self;
							}
						}
						if (targetRegion != noone)
						{
							instance_destroy(targetRegion);
						}
						
						var wall = instance_position(cursorX, cursorY, oGlitchWall);
						if (wall != noone)
						{
							instance_destroy(wall);
						}
					}
				}
				break;
			}
			case EDIT_STATE.REGION_GRABBED :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					grabbedRegion.x -= deltaX;
					grabbedRegion.y -= deltaY;
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_EDGE_TOP :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height + deltaY;
					grabbedRegion.y = newRegionY;
					grabbedRegion.height = newRegionHeight;
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_EDGE_LEFT :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
					
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width + deltaX;
					grabbedRegion.x = newRegionX;
					grabbedRegion.width = newRegionWidth;
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_EDGE_BOTTOM :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height - deltaY;
					grabbedRegion.height = newRegionHeight;
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_EDGE_RIGHT :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width - deltaX;
					grabbedRegion.width = newRegionWidth;
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_X1_Y1 :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
					
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width + deltaX;
					grabbedRegion.x = newRegionX;
					grabbedRegion.width = newRegionWidth;
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height + deltaY;
					grabbedRegion.y = newRegionY;
					grabbedRegion.height = newRegionHeight;
					
					grabbedX = xx;
					grabbedY = yy;
				}
				
				break;
			}
			case EDIT_STATE.RESIZE_X2_Y1 :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width - deltaX;
					grabbedRegion.width = newRegionWidth;
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height + deltaY;
					grabbedRegion.y = newRegionY;
					grabbedRegion.height = newRegionHeight;
					
					grabbedX = xx;
					grabbedY = yy;
				}
				
				break;
			}
			case EDIT_STATE.RESIZE_X2_Y2 :
			{
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width - deltaX;
					grabbedRegion.width = newRegionWidth;
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height - deltaY;
					grabbedRegion.height = newRegionHeight;
					
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			case EDIT_STATE.RESIZE_X1_Y2 :
			{
				
				if (mouse_check_button_released(mb_left))
				{
					grabbedRegion.isSelected = false;
					grabbedRegion = noone;
					cursorSprite = sCursor;
					editState = EDIT_STATE.IDLE;
				}
				else
				{
					var deltaX = (grabbedX - xx) * GRID_SIZE;
					var newRegionX = xx * GRID_SIZE;
					var newRegionWidth = grabbedRegion.width + deltaX;
					grabbedRegion.x = newRegionX;
					grabbedRegion.width = newRegionWidth;
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height - deltaY;
					grabbedRegion.height = newRegionHeight;
					
					grabbedX = xx;
					grabbedY = yy;
				}
				break;
			}
			default : 
			{
				break;
			}
		}
	}
	
}
else
{
	
}