//drawColor = colorNormal;
if (global.hackerMode)
{
	//drawColor = colorHacker;
	shader_set(SHD_CRT);

	// If using shader on GUI layer, set resolution
	var width = display_get_width();
	var height = display_get_height();
	
	CRT.SetResolution(width, height);
	shader_set_uniform_f_array(UCRTParams, CRT.Params);
}

gpu_set_blendenable(false);

var scaleFactor = window_get_height() / 288; // Need better than magic number here

draw_surface_ext(application_surface, 0, 0, scaleFactor, scaleFactor, 0, c_white, 1);
gpu_set_blendenable(true);

shader_reset();
