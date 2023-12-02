UCRTParams = shader_get_uniform(SHD_CRT, "params");
CRT = new CRTParameters();
CRT.Set(window_get_width(), window_get_height(), 4.0,   -8.0, -3.0,  32.0,  24.0,  0.5,  1.5,   1);

depth = -1000;
glitchIntensity = 0;
cursorSprite = sCursor;

application_surface_draw_enable(false);

var terminalWidth = 128;
var terminalHeight = 32;

terminalPanel = instance_create_layer(24, 164, "HackerMode", oHackerTerminal);
with (terminalPanel)
{
	//boundsWidth = camera_get_view_width(view_camera[0]);
	//boundsHeight = camera_get_view_height(view_camera[0]); 
	//boundsHeight = 128;
	//boundsX2 = x + boundsWidth;
	//boundsY2 = y + boundsHeight;
	drawMe = false;
	//sprite_index = sHackerTerminal;
	image_xscale = 4;
	image_yscale = 2;
}
draw_set_font(fntRetro);