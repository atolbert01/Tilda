if (!drawMe) return;

//draw_rectangle(boundsX1, boundsY1, boundsX2, boundsY2, true);
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, 0, c_white, alpha);
if (label != "") 
{
	draw_text_color(x + marginX, y, label, labelColor, labelColor, labelColor, labelColor, 0.8);
}

if (!surface_exists(terminalSurface))
{
	terminalSurface = surface_create(boundsX2 - boundsX1, boundsY2 - boundsY1 - 18);
}
surface_set_target(terminalSurface);
draw_clear_alpha(c_white, 0);

var historySize = ds_list_size(textHistory);
if (historySize > 0)
{
	for (var i = 0; i < historySize; i++)
	{
		draw_text_color(marginX + string_width("~ "), ((i) * breakHeight) - scrollOffset, textHistory[| i].text, textHistory[| i].color, textHistory[| i].color, textHistory[| i].color, textHistory[| i].color, 0.8);
	}
}

var terminalText = "~ " + value;
if (isActive && cursorVisible) terminalText += "|";
draw_text_color( marginX, (cursorRow * breakHeight) - scrollOffset, terminalText, textColor, textColor, textColor, textColor, 0.8);

surface_reset_target();
draw_surface(terminalSurface, x, y + 17);