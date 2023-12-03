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
}
else
{
	CRT.ShaderOn = false;
	glitchIntensity = 0;
	terminalPanel.isActive = false;
	instance_deactivate_object(terminalPanel);
}

show_hide_panel(terminalPanel);