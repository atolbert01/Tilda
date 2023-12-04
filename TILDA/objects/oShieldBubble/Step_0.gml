var strength = player.shieldStrength;

if (!coolDown)
{
	visible = true;
	if (strength > 0)
	{
		image_speed = (100 / strength) * 0.8;
		
		if (strength < 40)
		{
			if (image_index < 5) visible = false;
		}
	}
}