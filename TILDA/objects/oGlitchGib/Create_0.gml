subImage = random_range(0, image_number - 1);
frameDuration = random_range(6, 12);
frameCount = 0;
xOffset = 0;
yOffset = 0;
xScale = random_range(0.9, 1.1);
yScale = random_range(0.9, 1.1);
rotation = random_range(-3, 3);
alarm[0] = 20;

startX = x;
startY = y;
targetX = irandom_range(startX - 128, x + 128);
targetY = irandom_range(startY - 16, y - 256);
spd = random_range(2, 4);