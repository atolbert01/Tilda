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
		screen_shake(2, 0.25, 0.2);
		audio_play_sound(bump, 10, false);
		return true;
	}
	return false;
}

die = function()
{
	screen_shake(10, 2, 0.4);
	audio_play_sound(explosion, 10, false);
	var roomBounds = instance_place(x, y, oBounds);
	if (roomBounds)
	{
		roomBounds.remove_actor(self);
	}
	instance_destroy(self);
}