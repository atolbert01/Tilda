event_inherited();
player = oPlayer;
coolDown = false;
image_speed = 1;

hit = false;

is_hit = function()
{
	var bullet = instance_place(x, y, oBullet);
	if (bullet && !bullet.isPlayerOwned)
	{
		bullet.deactivate();
		hit = true;
		player.shieldStrength-=bullet.damage*4;
		screen_shake(2.5, 0.5, 0.2);
		return true;
	}
	return false;
}