active = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

actors = ds_list_create();
startValues = ds_list_create();

// Add additional object types to the object array as needed, e.g. hazards, doors, items, etc.
hasActors = collision_rectangle_list(x, y, x + width, y + height, [oEnemy], false, true, actors, false);
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

reset_room_bounds = function()
{
	if (hasActors)
	{
		var numActors = ds_list_size(actors);
		for (var i = 0; i < numActors; i++)
		{
			var actor = actors[| i];
			instance_destroy(actor);
		}
	}
	
	ds_list_clear(actors);
	
	var size = ds_list_size(startValues);
	for (var i = 0; i < size; i++)
	{
		var objectData = startValues[| i];
		var inst = instance_create_layer(objectData.x, objectData.y, objectData.layer, objectData.type);
		inst.doStep = false;
	}
	
	hasActors = collision_rectangle_list(x, y, x + width, y + height, [oEnemy], false, true, actors, false);
	active = false;
}

// Step is paused during reset. Unpause actors here.
unpause_actors = function()
{
	if (hasActors)
	{
		var numActors = ds_list_size(actors);
		for (var i = 0; i < numActors; i++)
		{
			var actor = actors[| i];
			if (instance_exists(actor)) actor.doStep = true;
		}
	}
}

remove_actor = function(inst)
{
	var i = ds_list_find_index(actors, inst);
	ds_list_delete(actors, i);
	if (ds_list_size(actors) < 1) hasActors = false;
}

if (hasActors) 
{
	var numActors = ds_list_size(actors);
	for (var i = 0; i < numActors; i++)
	{
		var actor = actors[| i];
		if (!active)
		{
			ds_list_add(startValues, { layer : actor.layer, x : actor.x, y : actor.y, type : actor.object_index });
			//instance_deactivate_object(actor);
		}
	}
	deactivate_actors();
}