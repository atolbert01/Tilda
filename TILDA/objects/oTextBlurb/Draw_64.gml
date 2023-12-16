var screenwidth = display_get_width();
var screenheight = display_get_height();
var textWidth = string_width(myText);


draw_text_color((screenwidth * 0.5) - (textWidth * 0.5), screenheight * 0.5, myText, c_white, c_white, c_white,c_white, 1);