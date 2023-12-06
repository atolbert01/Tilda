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

active = false;
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
#endregion

player = oPlayer;
depth = -1000;
//cursor = instance_create_depth(0, 0, -10000, oCursor);
cursor = instance_create_layer(0, 0, "HackerMode", oCursor);
terminalPanel = instance_create_layer(24, 164, "HackerMode", oHackerTerminal);
instance_deactivate_object(terminalPanel);
hsp = 0;
vsp = 0;
panSpeed = 8;
mousePan = false;
mousePrevX = 0;
mousePrevY = 0;
//glitchIntensity = 0;

#region Functions

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
		//apply_edits();
		instance_destroy(self);
	}
}

//update_glitch_intensity = function()
//{
//	glitchIntensity = (100 / player.glitchBudget) * 0.8;
//}

#endregion
