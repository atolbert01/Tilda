var player = instance_place(x, y, oPlayer);
if (!doQuickSave && player)
{
	player.lastCheckpoint = self;
	doQuickSave = true;
	sprite_index = sCheckpointQuicksave;
	image_index = 0;
}