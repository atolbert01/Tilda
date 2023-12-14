event_inherited();
deactivate = function()
{
	x = 1;
	y = 1;
	visible = false;
	instance_deactivate_object(self);
	ds_stack_push(roomManager.bullet1Pool, self);
	isPlayerOwned = false;
}