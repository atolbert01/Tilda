event_inherited();


txt = "Press ~ or TAB to enable hacker mode. Type help for options.";

execute = function()
{
	var screenwidth = display_get_width();
	var screenheight = display_get_height();
	var textWidth = string_width(txt);
	instance_create_layer(0, 0,"Instances", oTextBlurb, { myText : "Press ~ or TAB to enable hacker mode. Type help for options." });
}