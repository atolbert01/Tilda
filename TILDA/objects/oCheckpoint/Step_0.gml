if (!doQuickSave && instance_place(x, y, oPlayer))
{
	doQuickSave = true;
	sprite_index = sCheckpointQuicksave;
}

if (doQuickSave && sprite_index = sCheckpointQuicksave)
{
	  if (image_index > image_number - 1) 
	  {
		  sprite_index = sCheckpointIdle;
		  doQuickSave = false;
	  }
}