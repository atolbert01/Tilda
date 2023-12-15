event_inherited();
if (!doStep) exit;

if (!is_hit())
{
	
	
	switch (moveDir)
	{
		case MOVE_DIR.RIGHT :
		{
			if (place_empty(bbox_left, bbox_bottom + 1, oWall) && place_meeting(bbox_left - 1, bbox_bottom + 1, oWall))
			{
				moveDir = MOVE_DIR.DOWN;
			}
			else
			{
				x += walkSpeed;
			}
			break;
		}
		case MOVE_DIR.DOWN :
		{
			if (place_empty(bbox_left - 1, bbox_top, oWall) && place_meeting(bbox_left - 1, bbox_top - 1, oWall))
			{
				moveDir = MOVE_DIR.LEFT;
			}
			else
			{
				y += walkSpeed;
			}
			break;
		}
		case MOVE_DIR.LEFT :
		{
			if (place_empty(bbox_right + 1, bbox_top, oWall) && place_meeting(bbox_right + 1, bbox_top + 1, oWall))
			{
				moveDir = MOVE_DIR.UP;
			}
			else
			{
				x -= walkSpeed;
			}
			break;
		}
		case MOVE_DIR.UP :
		{
			if (place_empty(bbox_right + 1, bbox_bottom, oWall) && place_meeting(bbox_right + 1, bbox_bottom + 1, oWall))
			{
				moveDir = MOVE_DIR.RIGHT;
			}
			else
			{
				y -= walkSpeed;
			}
			break;
		}
	}
	
	
	//if (moveDir == MOVE_DIR.RIGHT)
	//{
	//	if (place_meeting(bbox_left + walkSpeed, bbox_bottom + 1, oWall) || place_meeting(bbox_right + walkSpeed, bbox_bottom + 1, oWall))
	//	{
	//		x += walkSpeed;
	//		moveDir = MOVE_DIR.RIGHT;
	//	}
	//}
	
	//else if (place_meeting(bbox_left, bbox_bottom + walkSpeed, oWall) || place_meeting(bbox_left, bbox_top + walkSpeed, oWall))
	//{
	//	y += walkSpeed;
	//	moveDir = MOVE_DIR.DOWN;
	//}
	//else if (place_meeting(bbox_left - walkSpeed, bbox_top, oWall) || place_meeting(bbox_right - walkSpeed, bbox_top, oWall))
	//{
	//	x -= walkSpeed;
	//	moveDir = MOVE_DIR.LEFT;
	//}
	//else if (place_meeting(bbox_right, bbox_bottom - walkSpeed, oWall) || place_meeting(bbox_right, bbox_top - walkSpeed, oWall))
	//{
	//	y -= walkSpeed;
	//	moveDir = MOVE_DIR.UP;
	//}
}