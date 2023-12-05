//image_xscale = 4;
//image_yscale = 2;

width = 64;
height = 32;

apply_edits = function()
{
	var overlappingWall = collision_rectangle(x, y, x + width, y + height, oGlitchWall, false, true);
		
	if (overlappingWall != noone 
		&& x <= overlappingWall.x && x + width >= overlappingWall.x + (image_xscale * GRID_SIZE)
		&& y <= overlappingWall.y && y + height >= overlappingWall.y + (image_yscale * GRID_SIZE)) {
			instance_destroy(overlappingWall);
	}
		
	// Multiplying x and y by half width/height because the origin of sGlitchTile is in the center. This makes it rotate better.
	instance_create_layer(x + (width * 0.5), y + (height * 0.5), "Terrain", oGlitchWall, { image_xscale : width / GRID_SIZE, image_yscale : height / GRID_SIZE});
	instance_destroy(self);
}