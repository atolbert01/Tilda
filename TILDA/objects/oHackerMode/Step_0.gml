if (!active) return;

// 192 is the tilde key. Consider allowing this to be swappable -- maybe with tab.
var toggleHackerMode = keyboard_check_pressed(192) || keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(0, gp_select);

if (toggleHackerMode) event_user(0);


var ctrlDown = keyboard_check(vk_control) | keyboard_check(vk_shift);
var enterPressed = keyboard_check_pressed(vk_enter);
var ePressed = keyboard_check_pressed(ord("E"));

if (ctrlDown && ePressed)
{
	show_debug_message(string(glitch_intensity(player)));
}

if (global.hackerMode)
{
	// Navigation keys
	var panRight = gamepad_axis_value(0, gp_axisrh) > 0.3 || gamepad_button_check(0, gp_padr);
	var panLeft = gamepad_axis_value(0, gp_axisrh) < -0.3 || gamepad_button_check(0, gp_padl);
	var panDown = gamepad_axis_value(0, gp_axisrv) > 0.3 || gamepad_button_check(0, gp_padd);
	var panUp = gamepad_axis_value(0, gp_axisrv) < -0.3 || gamepad_button_check(0, gp_padu);
	
	if (ctrlDown)
	{
		panRight |= keyboard_check(vk_right) | keyboard_check(ord("D"));
		panLeft |= keyboard_check(vk_left) | keyboard_check(ord("A"));
		panDown |= keyboard_check(vk_down) | keyboard_check(ord("S"));
		panUp |= keyboard_check(vk_up) | keyboard_check(ord("W"));
	}
	var midClickDown = mouse_check_button(mb_middle);
	
	hsp = (panRight - panLeft) * panSpeed;
	vsp = (panDown - panUp) * panSpeed;
	
	if (!midClickDown) mousePan = false;
	if (!mousePan && midClickDown)
	{
		mousePan = true;
		mousePrevX = mouse_x;
		mousePrevY = mouse_y;
	}
	if (mousePan)
	{
		hsp = mousePrevX - mouse_x;
		vsp = mousePrevY - mouse_y;
	}
	
	// Update camera
	var viewX = camera_get_view_x(view_camera[0]);
	var viewY = camera_get_view_y(view_camera[0]);
	var viewWidth = camera_get_view_width(view_camera[0]);
	var viewHeight = camera_get_view_height(view_camera[0]);
	
	camera_set_view_pos(view_camera[0], clamp(viewX + hsp, 0, room_width - viewWidth), clamp(viewY + vsp, 0, room_height - viewHeight));
	
	// EDIT MODE
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
				// Save these edits on enter
				//if (ctrlDown && ePressed)
				if (enterPressed)
				{ 
					var glitchCost = 0;
					for (var i = 0; i < instance_number(oRegion); i++;)
					{
					    var region = instance_find(oRegion, i);
						glitchCost -= (region.width / GRID_SIZE) * (region.height / GRID_SIZE);
					}
					
					with(oRegion) 
					{
						apply_edits(); 
					}
					
					set_glitch_budget(player, glitchCost);
					cursorSprite = sCursor;
				}
				
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
							else // Place a new region
							{
								var newRegion = instance_create_layer(regionX, regionY, "HackerMode", oRegion);
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
							cursorSprite = sCursor;
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
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.y = newRegionY;
						grabbedRegion.height = newRegionHeight;
						grabbedX = xx;
						grabbedY = yy;
					}
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.x = newRegionX;
						grabbedRegion.width = newRegionWidth;
						grabbedX = xx;
						grabbedY = yy;
					}
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
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.height = newRegionHeight;
						grabbedX = xx;
						grabbedY = yy;
					}
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.width = newRegionWidth;
						grabbedX = xx;
						grabbedY = yy;
					}
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.x = newRegionX;
						grabbedRegion.width = newRegionWidth;
					}

					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height + deltaY;
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.y = newRegionY;
						grabbedRegion.height = newRegionHeight;
					}
					
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.width = newRegionWidth;
					}
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height + deltaY;
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.y = newRegionY;
						grabbedRegion.height = newRegionHeight;
					}
					
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.width = newRegionWidth;
					}
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height - deltaY;
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.height = newRegionHeight;
					}
					
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
					if (newRegionWidth > GRID_SIZE)
					{
						grabbedRegion.x = newRegionX;
						grabbedRegion.width = newRegionWidth;
					}
					
					
					var deltaY = (grabbedY - yy) * GRID_SIZE;
					var newRegionY = yy * GRID_SIZE;
					var newRegionHeight = grabbedRegion.height - deltaY;
					if (newRegionHeight > GRID_SIZE)
					{
						grabbedRegion.height = newRegionHeight;
					}
					
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
//else
//{
	
//}