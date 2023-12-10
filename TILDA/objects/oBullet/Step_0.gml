if (!doStep) exit;

x += spd * cos(degtorad(dir));
y += spd * sin(-degtorad(dir));

// If out of bounds, move in bounds, deactivate and add to the bullet pool
if (x > room_width || x < 0 || y > room_height || y < 0 || instance_place(x, y, oWall))
{
	deactivate();
}