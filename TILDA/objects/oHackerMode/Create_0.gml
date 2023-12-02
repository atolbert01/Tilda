UCRTParams = shader_get_uniform(SHD_CRT, "params");
CRT = new CRTParameters();
CRT.Set(window_get_width(), window_get_height(), 4.0,   -8.0, -3.0,  32.0,  24.0,  0.5,  1.5,   1);

//depth = -1000;
glitchIntensity = 0;
cursorSprite = sCursor;

application_surface_draw_enable(false);