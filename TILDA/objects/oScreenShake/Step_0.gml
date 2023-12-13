if (doShake)
{
	if (instance_exists(oPlayer))
	{
		camStartX = oPlayer.adjCamX;
		camStartY = oPlayer.adjCamY;
	}
	shakeTime -= 1;
	var xVal = choose(camStartX - shakeMagnitude, camStartX + shakeMagnitude);
	var yVal = choose(camStartY - shakeMagnitude, camStartY + shakeMagnitude);
	camera_set_view_pos(view_camera[0], xVal, yVal);
	
	if (shakeTime <= 0)
	{
		shakeMagnitude -= shakeFade;
		
		if (shakeMagnitude <= 0)
		{
			camera_set_view_pos(view_camera[0], camStartX, camStartY);
			doShake = false;
		}
	}
}