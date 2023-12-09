event_inherited();

facing = 0;
hsp = 0;
walkSpeed = 2;

roomManager = oRoomManager;
player = oPlayer;
eyeLevel = (bbox_bottom - bbox_top) * 0.66;
gunLevel = (bbox_bottom - bbox_top) * 0.5;
shotTimer = -1;
aimTime = 15;
aimDir = 0;

coolDownPeriod = 200;
coolDownTimer = coolDownPeriod;

hit = false;

shoot_bullet = function()
{
	aimDir = point_direction(x, y - gunLevel, player.x, player.center_y());
	var bullet = ds_stack_pop(roomManager.bullet2Pool) ?? instance_create_depth(x, y - gunLevel, -100, oBullet2);

	with (bullet)
	{ 
		instance_activate_object(self);
		visible = true;
		x = other.x;
		y = other.y - other.gunLevel;
		roomManager = other.roomManager;
		spd = 8;
		dir = other.aimDir;
	}
	coolDownTimer = coolDownPeriod;
}