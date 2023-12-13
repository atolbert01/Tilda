var player = instance_place(x, y, oPlayer);
if (!doQuickSave && player)
{
	with(oCheckpoint)
	{
		doQuickSave = false;
		sprite_index = sCheckpointIdle;
	}
	player.lastCheckpoint = self;
	doQuickSave = true;
	sprite_index = sCheckpointQuicksave;
	image_index = 0;
}