event_inherited();
player = oPlayer;
coolDown = false;
image_speed = 1;

hit = false;
safetyTimer = 0;
safetyInterval = 30;
is_hit = function()
{
	if (safetyTimer > 0) return false;
	
	var bullet = instance_place(x, y, oBullet);
	if (bullet && !bullet.isPlayerOwned)
	{
		bullet.deactivate();
		hit = true;
		player.shieldStrength-=bullet.damage*4;
		audio_play_sound(take_hit, 10, false);
		screen_shake(2.5, 0.5, 0.2);
		return true;
	}
	
	var enemy = instance_place(x, y, oEnemy)
	if (enemy)
	{
		hit = true;
		hsp = 0;
		player.shieldStrength-=enemy.damage*4;
		safetyTimer = safetyInterval;
		audio_play_sound(take_hit, 10, false);
		screen_shake(2.5, 0.5, 0.2);
		return true;
	}
	
	return false;
}