/// @description Toggle Hacker Mode

// Do some initial setup after toggling
global.hackerMode = !global.hackerMode;

if (global.hackerMode)
{
	with(oGameActor)
	{
		doStep = false;
	}
	CRT.ShaderOn = true;
	//glitchIntensity = 0.025;
	
	instance_activate_object(terminalPanel);
	terminalPanel.isActive = true;
	
	if (editMode) with(oRegion) visible = true;
}
else
{
	with(oGameActor)
	{
		doStep = true;
	}
	CRT.ShaderOn = false;
	//glitchIntensity = 0;
	terminalPanel.isActive = false;
	cursor.sprite_index = sCursor;
	
	with(oRegion)
	{
		visible = false;
	}
	
	instance_deactivate_object(terminalPanel);
}

show_hide_panel(terminalPanel);