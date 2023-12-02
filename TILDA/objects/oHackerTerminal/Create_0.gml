// Inherit the parent event
event_inherited();
subElements = [];

label = "HACKER_STONE";
value = "...";
valuePrev = "...";

charLimit = 8;
marginX = 2;
marginY = 1;

boundsHeight = string_height(value) + (marginY * 2);
boundsX1 = x;
boundsY1 = y;
boundsX2 = x + boundsWidth;
boundsY2 = y + boundsHeight;

cursorVisible = false;
allowLetters = true;
allowNumbers = true;

enabledLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
enabledNumbers = "0123456789";

alpha = 0.8;