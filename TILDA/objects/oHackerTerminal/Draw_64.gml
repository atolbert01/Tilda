if (!drawMe) return;

if (!surface_exists(terminalSurface))
{
	terminalSurface = surface_create(boundsX2 - boundsX1, boundsY2 - boundsY1);
}
surface_set_target(terminalSurface);

draw_sprite_ext(sprite_index, -1, 0, 0, image_xscale, image_yscale, 0, c_white, alpha);

if (label != "") 
{
	draw_text_color(marginX, 0, label, labelColor, labelColor, labelColor, labelColor, 0.8);
}

var historySize = ds_list_size(textHistory);
if (historySize > 0)
{
	for (var i = 0; i < historySize; i++)
	{
		draw_text_color(marginX + string_width("~ "), (i + 1) * breakHeight, textHistory[| i], inactiveColor, inactiveColor, inactiveColor, inactiveColor, 0.8);
	}
}

var terminalText = "~ " + value;
if (isActive && cursorVisible) terminalText += "|";
draw_text_color( marginX, 0 + (cursorRow * breakHeight), terminalText, textColor, textColor, textColor, textColor, 0.8);

surface_reset_target();
draw_surface(terminalSurface, x, y);