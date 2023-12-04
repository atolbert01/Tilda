if (keyShootHeld) 
{
	alarm[1] = shieldCoolDownTime;
	return;
}

with (shield) event_user(0);
//with (oShieldBubble) event_user(0);