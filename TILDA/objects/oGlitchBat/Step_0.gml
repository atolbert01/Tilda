event_inherited();
if (!doStep) return;

is_hit();

if (moveTimer > 0)
{
	moveTimer--
}
else
{
	// Move
	moveTimer = moveInterval;
	
	var moveDir = irandom_range(0, 3);
	switch (moveDir)
	{
		case 0 :
		{
			x-=16;
			//body.x-=16;
			wingL.x-=16;
			wingR.x-=16;
			break;
		}
		case 1 :
		{
			x+=16;
			//body.x+=16;
			wingL.x+=16;
			wingR.x+=16;
			break;
		}
		case 2 :
		{
			y-=16;
			//body.y-=16;
			wingL.y-=16;
			wingR.y-=16;
			break;
		}
		case 3 :
		{
			y+=16;
			//body.y+=16;
			wingL.y+=16;
			wingR.y+=16;
			break;
		}
	}
}

// Flap wings
if (wingFlapTimer > 0) wingFlapTimer--;
else
{
	wingFlapTimer = wingFlapInterval;
	if (instance_exists(wingL))
	{
		if (wingL.y <= y)
		{
			wingL.y += 16;
			wingR.y += 16;
		}
		else if (wingL.y > y)
		{
			wingL.y -= 16;
			wingR.y -= 16;
		}
	}
}