game_set_speed(60, gamespeed_fps); // We'll lock it at 60
randomize();
draw_set_font(fntRetro);


checkpoints = ds_map_create();

/// @description: Adds a checkpoint to the map. Creates a unique tag for the checkpoint and saves the checkpoint as a struct with location : room, reference : checkpoint.
add_checkpoint = function(checkpoint)
{
	ds_map_add(checkpoints, checkpoint.tagString, { location: room, reference : checkpoint } );
}

load_checkpoint = function(tag)
{
	
}


//var rm = room;
//while (room_exists(rm))
//{
//	rm = room_next(rm);
//	var info = room_get_info(rm);
//}