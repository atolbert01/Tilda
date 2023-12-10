doStep = true;
isPlayerOwned = false;
roomManager = undefined;
spd = 0;
dir = 0;

deactivate = function()
{
	x = 1;
	y = 1;
	visible = false;
	instance_deactivate_object(self);
	ds_stack_push(roomManager.bullet2Pool, self);
	isPlayerOwned = false;
}