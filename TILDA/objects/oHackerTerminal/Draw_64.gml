if (!drawMe) return;

draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, 0, c_white, alpha);
if (label != "") 
{
	//draw_set_alpha(0.67);
	//draw_set_color(0x393c32);
	draw_set_color(0x6e9437)
	draw_text(x + marginX, y, label);
}
draw_set_color(0x30be6a)
draw_text(x + marginX, y + 16, "~ " + value);

draw_set_color(c_white);
draw_set_alpha(1);