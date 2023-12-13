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
		//hsp = 0;
		//vsp = 0;
		player.shieldStrength-=bullet.damage*4;
		//if (hitPoints <= 0) die();
		
		return true;
	}
	return false;
}