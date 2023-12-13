event_inherited();
if (!doStep) 
{
	exit;
}

var strength = player.shieldStrength;

if (!coolDown)
{
	visible = true;
	if (is_hit())
	{
		player.recoveryTimer = player.recoveryInterval;
	}
	else if (strength > 0)
	{
		image_speed = (100 / strength) * 0.8;
		
		if (strength < 40)
		{
			if (image_index < 5) visible = false;
		}
	}
}