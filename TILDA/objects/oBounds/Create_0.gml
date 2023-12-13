active = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

actors = ds_list_create();
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
				//if (object_get_parent(actor.object_index) == oEnemy) 
				//{
				//	instance_deactivate_object(actor);
				//}
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
				//if (object_get_parent(actor.object_index) == oEnemy) 
				//{
				//	instance_activate_object(actor);
				//}
			}
		}
	}	
}

if (hasActors) deactivate_actors();