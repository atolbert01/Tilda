if (!doQuickSave && instance_place(x, y, oPlayer))
{
	doQuickSave = true;
	sprite_index = sCheckpointQuicksave;
	image_index = 0;
}