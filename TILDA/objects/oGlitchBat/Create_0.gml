event_inherited();

subImage = random_range(0, image_number - 1);
frameDuration = random_range(6, 12);
frameCount = 0;
xOffset = 0;
yOffset = 0;
xScale = random_range(0.9, 1.1);
yScale = random_range(0.9, 1.1);
rotation = random_range(-3, 3);

roomBounds = instance_place(x, y, oBounds);

//body = instance_create_layer(x, y, "Instances", oGlitchPart);
wingL = instance_create_layer(x - 16, y - 16, "Instances", oGlitchPart);
wingR = instance_create_layer(x + 16, y - 16, "Instances", oGlitchPart);

moveInterval = 120;
moveTimer = moveInterval;

wingFlapInterval = 10;
wingFlapTimer = wingFlapInterval;

die = function()
{
	screen_shake(10, 2, 0.4);
	instance_destroy(self);
	instance_destroy(wingL);
	instance_destroy(wingR);
}