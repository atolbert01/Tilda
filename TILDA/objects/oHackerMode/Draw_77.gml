//drawColor = colorNormal;
if (global.hackerMode)
{
	//drawColor = colorHacker;
	shader_set(SHD_CRT);

	// If using shader on GUI layer, set resolution
	var width = display_get_width();
	var height = display_get_height();
	if (!window_get_fullscreen())
	{
		width = oCamera.camWidth * oCamera.camWindowScale;
		height = oCamera.camHeight * oCamera.camWindowScale;
	}
	
	//CRT.SetResolution(window_get_width(), window_get_height());
	CRT.SetResolution(width, height);
	shader_set_uniform_f_array(UCRTParams, CRT.Params);
}

gpu_set_blendenable(false);

var xscale = display_get_width() / 576;
var yscale = display_get_height() / 288;

if (!window_get_fullscreen())
{
	xscale = oCamera.camWindowScale;
	yscale = oCamera.camWindowScale;
}

draw_surface_ext(application_surface, 0, 0, xscale, yscale, 0, c_white, 1);
gpu_set_blendenable(true);

shader_reset();
