alpha = clamp(alpha + (fade * 0.05), 0, 1);

// What to do after the fade
if (alpha == 1)
{
	//if (room_exists(room_next(room)) && room_get_name(room) == "Splash") room_goto_next();
	//else room_restart();
	//room_restart();
	
	if (room_exists(targetRoom)) room_goto(targetRoom);
	else room_restart();
	
	fade = -1;
}

if (alpha == 0 && fade == -1)
{
	instance_destroy();
}

draw_set_color(c_black);
draw_set_alpha(alpha);
draw_rectangle(
	camera_get_view_x(view_camera[0]), 
	camera_get_view_y(view_camera[0]),
	camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]),
	camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]),
	0);
	
draw_set_alpha(1);