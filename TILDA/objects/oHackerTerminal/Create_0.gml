// Inherit the parent event
event_inherited();
subElements = [];

label = "HACKER_STONE";
value = "";
valuePrev = "";

charLimit = 18;
marginX = 2;
marginY = 1;
breakHeight = 16;
cursorVisible = false;
cursorRow = 0;

boundsHeight = string_height(value) + (marginY * 2);
boundsX1 = x;
boundsY1 = y;
boundsX2 = x + boundsWidth;
boundsY2 = y + boundsHeight;

allowLetters = true;
allowNumbers = true;

enabledLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
enabledNumbers = "0123456789";

alpha = 0.8;

activeColor = 0x30be6a;
inactiveColor = 0x2f694b;

textColor = activeColor;

responseColor = 0x36f2fb;
labelColor = 0x6e9437;

textHistory = ds_list_create();

terminalSurface = noone;

scrollOffset = 0;