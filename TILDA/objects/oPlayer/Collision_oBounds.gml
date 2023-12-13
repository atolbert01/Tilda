if (roomBounds != other) 
{
	if (roomBounds != noone)
	{
		roomBounds.active = false;
		roomBounds.deactivate_actors();
	}
	roomBounds = other;
	roomBounds.active = true;
	roomBounds.activate_actors();
	//instance_create_layer(0, 0, "Transition", oFade);
}