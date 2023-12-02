// 192 is the tilde key. Consider allowing this to be swappable -- maybe with tab.
var toggleHackerMode = keyboard_check_pressed(192) || keyboard_check_pressed(vk_tab) || gamepad_button_check_pressed(0, gp_select);

if (toggleHackerMode) event_user(0);

if (global.hackerMode)
{
	
}
else
{
	
}