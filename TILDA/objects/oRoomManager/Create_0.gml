bullet1Pool = ds_stack_create();
bullet2Pool = ds_stack_create();
checkpoints = ds_map_create();
add_checkpoint = function(tag, checkpoint)
{
	ds_map_add(checkpoints, tag, checkpoint);
}