if (global.hackerMode)
{
	draw_rectangle_color(tagX - 1, tagY - 1, tagX + tagWidth + 1, tagY + tagHeight + 1, 0x30be6a, 0x30be6a, 0x30be6a, 0x30be6a, true);
	draw_rectangle_color(tagX, tagY, tagX + tagWidth, tagY + tagHeight, 0x393c32, 0x393c32, 0x393c32, 0x393c32, false);
	draw_text_color(tagX, tagY, tagString, 0x30be6a, 0x30be6a, 0x30be6a, 0x30be6a, 1);
}
draw_set_color(c_white);
draw_self();