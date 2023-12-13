if (!doStep) exit;

hsp = 0;
var bullet = instance_place(x, y, oBullet);
//if (bullet && bullet.isPlayerOwned)
//{
//	bullet.deactivate();
//	hit = true;
//	hsp = 0;
//	health--;
//	if (health <= 0) die();
//}
//else 
if (!is_hit())
{
	if (shotTimer < 0)
	{
		// Facing right
		if (facing == 0)
		{
			// Am I on the ground?
			if (place_meeting(x, y + 1, oWall)) 
			{
				hsp = walkSpeed;
				if (place_meeting(bbox_right, y + 1, oWall) && !place_meeting(bbox_right + hsp, y - 1, oWall))
				{
					image_xscale = 1;
				}
				else
				{
					facing = 180;
					hsp = -walkSpeed;
				}
		
				if (coolDownTimer < 0)
				{
					if (facing == 0 && player.x > x && distance_to_point(player.x, player.y) < 160)
					{
						var x1 = x;
						var y1 = y - eyeLevel;
						var x2 = player.x;
						var y2 = player.y - ((player.bbox_bottom - player.bbox_top) * 0.5);
						var col = collision_line_first(x1, y1, x2, y2, [oWall, oPlayer], false, true);
						if (col.id == player.id)
						{
							hsp = 0;
							shotTimer = aimTime;
						}
					}
				}
			}
		}
		else
		{
			if (place_meeting(x, y + 1, oWall)) 
			{
				hsp = -walkSpeed;
				if (place_meeting(bbox_left, y + 1, oWall) && !place_meeting(bbox_left + hsp, y - 1, oWall))
				{
					image_xscale = -1;
				}
				else
				{
					facing = 0;
					hsp = walkSpeed;
				}
			
				if (coolDownTimer < 0)
				{
					if (facing == 180 && player.x < x && distance_to_point(player.x, player.y) < 160)
					{
						var x1 = x;
						var y1 = y - eyeLevel;
						var x2 = player.x;
						var y2 = player.y - ((player.bbox_bottom - player.bbox_top) * 0.5);
						var col = collision_line_first(x1, y1, x2, y2, [oWall, oPlayer], false, true);
						if (col.id == player.id)
						{
							hsp = 0;
							shotTimer = aimTime;
						}
					}
				}
			}
		}
		coolDownTimer--;
	}
	else
	{
		shotTimer--;
		if (shotTimer < 0)
		{
			shoot_bullet();
		}
	}
	
}

x += hsp;