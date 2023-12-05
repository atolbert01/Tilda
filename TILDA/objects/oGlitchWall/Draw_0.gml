/// @description Insert description here
// You can write your code in this editor


frameCount += 1;
if (frameCount >= frameDuration)
{
	frameCount = 0;
	frameDuration = random_range(6, 12);
	subImage = random_range(0, image_number - 1);
	xOffset = random_range(-2, 2);
	yOffset = random_range(-2, 2);
	xScale = random_range(0.9, 1.1);
	yScale = random_range(0.9, 1.1);
	rotation = random_range(-3, 3);
}

draw_sprite_ext(sprite_index, subImage, x + xOffset, y + yOffset, image_xscale * xScale, image_yscale * yScale, rotation, c_white, 1);




