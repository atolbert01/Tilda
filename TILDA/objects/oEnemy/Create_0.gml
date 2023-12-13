event_inherited();
hitPoints = 10;
damage = 5;
player = oPlayer;
roomManager = oRoomManager;
hsp = 0;
vsp = 0;
hit = false;

is_hit = function()
{
	var bullet = instance_place(x, y, oBullet);
	if (bullet && bullet.isPlayerOwned)
	{
		bullet.deactivate();
		hit = true;
		hsp = 0;
		vsp = 0;
		hitPoints-=bullet.damage;
		if (hitPoints <= 0) die();
		
		return true;
	}
	return false;
}

die = function()
{
	instance_destroy(self);
}