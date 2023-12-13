function screen_shake(_time, _magnitude, _fade)
{
	with (oScreenShake)
	{
		camStartX = camera_get_view_x(view_camera[0]);
		camStartY = camera_get_view_y(view_camera[0]);
		doShake = true;
		shakeTime = _time;
		shakeMagnitude = _magnitude;
		shakeFade = _fade;
	}
}