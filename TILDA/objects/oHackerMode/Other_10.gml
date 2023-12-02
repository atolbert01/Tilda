/// @description Toggle Hacker Mode
// Do some initial setup after toggling
global.hackerMode = !global.hackerMode;
with(oGameActor)
{
	doStep = !doStep;
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