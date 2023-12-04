/// @description Toggle Hacker Mode

// Do some initial setup after toggling
global.hackerMode = !global.hackerMode;
with(oGameActor)
{
	doStep = !global.hackerMode;
	//speed = 0;
}

if (global.hackerMode)
{
	CRT.ShaderOn = true;
	glitchIntensity = 0.025;
	
	instance_activate_object(terminalPanel);
	terminalPanel.isActive = true;
	
	if (editMode) with(oRegion) visible = true;
}
else
{
	CRT.ShaderOn = false;
	glitchIntensity = 0;
	terminalPanel.isActive = false;
	cursorSprite = sCursor;
	
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
	
	instance_deactivate_object(terminalPanel);
}

show_hide_panel(terminalPanel);