if (hit)
{
	hit = false;
	shader_set(shdFlash);
}
draw_self();
shader_reset();