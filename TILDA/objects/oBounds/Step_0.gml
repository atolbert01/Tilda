if (!active) return;

if (instance_exists(oHackerStone))
{
	var budget = oPlayer.glitchBudget;

	if (budget > 25 && budget < 75)
	{
		if (glitchTimer > budget * glitchModifier) glitchTimer = budget * glitchModifier;
		if (glitchTimer > 0) glitchTimer--;
		else
		{
			var chance = irandom_range(1, 6);
			var choice = irandom_range(1, 2);
			if (budget > 50 && chance == 1)
			{
				if (choice == 1) create_random_instance();
				else if (choice == 2) spawn_glitch_bat();
				glitchTimer = budget * glitchModifier;
			}
			else if (budget < 50 && budget > 25 && chance <= 2)
			{
				if (choice == 1) create_random_instance();
				else if (choice == 2) spawn_glitch_bat();
				glitchTimer = budget * glitchModifier;
			}
		}
	}
	else if (budget <= 25)
	{
		if (glitchTimer > 25 * glitchModifier) glitchTimer = 25 * glitchModifier;
		if (glitchTimer > 0) glitchTimer--;
		else
		{
			var chance = irandom_range(1, 6);
			var choice = irandom_range(1, 2);
			if (budget < 25 && budget >= 0 && chance <= 3)
			{
				if (choice == 1) create_random_instance();
				else if (choice == 2) spawn_glitch_bat();
				glitchTimer = 25 * glitchModifier;
			}
		}
	}
}
