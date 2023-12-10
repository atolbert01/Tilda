game_set_speed(60, gamespeed_fps); // We'll lock it at 60
randomize();
draw_set_font(fntRetro);


checkpoints = ds_map_create();

/// @description: Adds a checkpoint to the map. Creates a unique tag for the checkpoint and saves the checkpoint as a struct with location : room, reference : checkpoint.
add_checkpoint = function(checkpoint)
{
	var tag = dec_to_hex(ds_map_size(checkpoints), 4);
	ds_map_add(checkpoints, tag, { location: room, reference : checkpoint } );
	return tag;
}

load_checkpoint = function(tag)
{
	
}