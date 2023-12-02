function show_hide_panel(panel)
{
	// Set drawMe before calling
	panel.drawMe = !panel.drawMe;
	for (var i = 0; i < array_length(panel.subElements); i++)
	{
		var e = panel.subElements[i];
		e.drawMe = panel.drawMe;
		e.enabled = e.drawMe;
	}
}