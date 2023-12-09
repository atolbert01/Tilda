if (!doStep) exit;

//motion_set(dir, spd);
x += spd * cos(degtorad(dir));
y += spd * sin(-degtorad(dir));

// If out of bounds, move in bounds, deactivate and add to the bullet pool
if (x > room_width || x < 0 || y > room_height || y < 0)
{
	x = 1;
	y = 1;
	visible = false;
	instance_deactivate_object(self);
	ds_stack_push(roomManager.bullet2Pool, self);
	
	//show_debug_message("Bullets in pool: " + string(ds_stack_size(roomManager.bullet1Pool)));
}