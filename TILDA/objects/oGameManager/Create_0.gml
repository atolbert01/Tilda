game_set_speed(60, gamespeed_fps); // We'll lock it at 60
randomize();
draw_set_font(fntRetro);

audio_group_load(music);

checkpoints = ds_map_create();

add_checkpoint = function(checkpoint)
{
	ds_map_add(checkpoints, checkpoint.tagString, checkpoint );
}

playSound = true;
if (!playSound) audio_master_gain(0);

instance_create_layer(x, y, "System", oTutorialManager);