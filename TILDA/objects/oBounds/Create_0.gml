active = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

actors = ds_list_create();
//startValues = ds_list_create();

// Add additional object types to the object array as needed, e.g. hazards, doors, items, etc.
hasActors = collision_rectangle_list(x, y, x + width, y + width, [oEnemy], false, true, actors, false);
deactivate_actors = function()
{
	if (hasActors)
	{
		var numActors = ds_list_size(actors);
		for (var i = 0; i < numActors; i++)
		{
			var actor = actors[| i];
			if (!active)
			{
				instance_deactivate_object(actor);
			}
		}
	}	
}

activate_actors = function()
{
	if (hasActors)
	{
		var numActors = ds_list_size(actors);
		for (var i = 0; i < numActors; i++)
		{
			var actor = actors[| i];
			if (active)
			{
				instance_activate_object(actor);
			}
		}
	}	
}

//reset_room_bounds = function()
//{
	
//}

if (hasActors) 
{
	//var numActors = ds_list_size(actors);
	//for (var i = 0; i < numActors; i++)
	//{
	//	var actor = actors[| i];
	//	if (!active)
	//	{
	//		ds_list_add(startValues, { x : actor.x, y : actor.y, type : actor.object_index });
	//		//instance_deactivate_object(actor);
	//	}
	//}
	deactivate_actors();
}