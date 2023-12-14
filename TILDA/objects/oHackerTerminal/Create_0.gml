// Inherit the parent event
event_inherited();
subElements = [];

drawMe = false;
image_xscale = 4;
image_yscale = 2;


//show_debug_message(string(sprite_width) + ", " + string(sprite_height));

label = "HACKER_STONE";
value = "";
valuePrev = "";

charLimit = 18;
marginX = 2;
marginY = 1;
breakHeight = 16;
cursorVisible = false;
cursorRow = 0;

//boundsHeight = string_height(value) + (marginY * 2);


boundsWidth = sprite_width
boundsHeight = sprite_height;

boundsX1 = x;
boundsY1 = y;
boundsX2 = x + boundsWidth;
boundsY2 = y + boundsHeight;


// use these to snap back into place if the player loses me
startX = x;
startY = y;

allowLetters = true;
allowNumbers = true;

enabledLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
enabledNumbers = "0123456789";

alpha = 0.8;

activeColor = 0x30be6a;
inactiveColor = 0x2f694b;

textColor = activeColor;

debugColor = 0x36f2fb;
labelColor = 0x6e9437;
errorColor = 0x3232ac;

textHistory = ds_list_create();

terminalSurface = noone;

scrollOffset = 0;

hackerMode = oHackerMode;
