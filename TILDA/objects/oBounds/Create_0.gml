active = false;
width = bbox_right - bbox_left;
height = bbox_bottom - bbox_top;

glitchModifier = 12;
glitchTimer = 100 * glitchModifier;

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
	
	with (oGlitchBat)
	{
		die();
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

create_random_instance = function()
{
	if (ds_list_size(startValues) < 1) return;
	var size = ds_list_size(startValues);
	var choice = irandom_range(0, size - 1);
	var objectData = startValues[| choice];
	var inst = instance_create_layer(objectData.x, objectData.y, objectData.layer, objectData.type);
	//inst.doStep = false;
}

spawn_glitch_bat = function()
{
	// Spawn near the player
	var xx = irandom_range(oPlayer.x - 128, oPlayer.x + 128);
	var yy = irandom_range(oPlayer.y - 128, oPlayer.y + 128);
	
	instance_create_layer(xx, yy, "Instances", oGlitchBat);
	
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