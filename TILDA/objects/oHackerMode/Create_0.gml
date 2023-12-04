#region Shaders

UCRTParams = shader_get_uniform(SHD_CRT, "params");
CRT = new CRTParameters();
CRT.Set(window_get_width(), window_get_height(), 4.0,   -8.0, -3.0,  32.0,  24.0,  0.5,  1.5,   1);

// Activating the shader
bktglitch_activate();
application_surface_draw_enable(false);

#endregion


#region EditMode

enum EDIT_STATE
{
	IDLE,
	REGION_GRABBED,
	RESIZE_X1_Y1,
	RESIZE_X2_Y1,
	RESIZE_X2_Y2,
	RESIZE_X1_Y2,
	RESIZE_EDGE_TOP,
	RESIZE_EDGE_LEFT,
	RESIZE_EDGE_BOTTOM,
	RESIZE_EDGE_RIGHT,
}

enum REGION_CORNER
{
	X1_Y1,
	X2_Y1,
	X2_Y2,
	X1_Y2,
}

enum REGION_EDGE
{ // Can use even vs odd values for comparisons
	NONE,	// 0
	TOP,	// 1
	LEFT,	// 2
	BOTTOM, // 3
	RIGHT,  // 4 
}

editMode = false;
editState = EDIT_STATE.IDLE;
grabbedRegion = noone;
grabbedX = 0;
grabbedY = 0;

regionWidth = 64;
regionHeight = 32;

gridWidth = room_width / GRID_SIZE;
gridHeight = room_height / GRID_SIZE;

padAmount = 8;

deselect = function()
{
	editState = EDIT_STATE.IDLE;
	with (oRegion)
	{
		isSelected = false;
	}
}

exit_edit_mode = function()
{
	
	editState = EDIT_STATE.IDLE;
	editMode = false;
	with(oRegion)
	{
		var overlappingWall = collision_rectangle(x, y, x + width, y + height, oGlitchWall, false, true);
		
		if (overlappingWall != noone 
			&& x <= overlappingWall.x && x + width >= overlappingWall.x + (image_xscale * GRID_SIZE)
			&& y <= overlappingWall.y && y + height >= overlappingWall.y + (image_yscale * GRID_SIZE)) {
				instance_destroy(overlappingWall);
		}
		
		instance_create_layer(x, y, "Terrain", oGlitchWall, { image_xscale : width / GRID_SIZE, image_yscale : height / GRID_SIZE});
		visible = false;
	}
}

#endregion

player = oPlayer;
depth = -1000;
cursorSprite = sCursor;
terminalPanel = instance_create_layer(24, 164, "HackerMode", oHackerTerminal);
instance_deactivate_object(terminalPanel);
glitchIntensity = 0;