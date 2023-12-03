UCRTParams = shader_get_uniform(SHD_CRT, "params");
CRT = new CRTParameters();
CRT.Set(window_get_width(), window_get_height(), 4.0,   -8.0, -3.0,  32.0,  24.0,  0.5,  1.5,   1);

depth = -1000;
glitchIntensity = 0;
cursorSprite = sCursor;

// Activating the shader
bktglitch_activate();

application_surface_draw_enable(false);

//var terminalWidth = 128;
//var terminalHeight = 32;

terminalPanel = instance_create_layer(24, 164, "HackerMode", oHackerTerminal);

//with (terminalPanel)
//{
//	drawMe = false;
//	image_xscale = 4;
//	image_yscale = 2;
	
//	boundsX1 = bbox_left;
//	boundsY1 = bbox_top;
//	boundsX2 = bbox_right;
//	boundsY2 = bbox_bottom;
//	//boundsX2 = x + (16 * image_xscale);
//	//boundsY2 = y + (16 * image_yscale);
//}
instance_deactivate_object(terminalPanel);

draw_set_font(fntRetro);