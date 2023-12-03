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
}
else
{
	CRT.ShaderOn = false;
	glitchIntensity = 0;
}

show_hide_panel(terminalPanel);