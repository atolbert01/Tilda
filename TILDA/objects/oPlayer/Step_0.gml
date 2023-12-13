// Inherit the parent event
event_inherited();
if (!doStep) exit;

var f1 = keyboard_check_pressed(vk_f1);
var f2 = keyboard_check_pressed(vk_f2);

var gpAim = gamepad_button_check(0, gp_shoulderr) || gamepad_button_check(0, gp_shoulderl);
var keyAim = mouse_check_button(mb_right) || keyboard_check(vk_shift) || keyboard_check(ord("C")) || gpAim;

var gpRight = gamepad_axis_value(0, gp_axislh) > 0.3 || gamepad_button_check(0, gp_padr)
var keyRight = keyboard_check(vk_right) || keyboard_check(ord("D")) || gpRight;

var gpLeft = gamepad_axis_value(0, gp_axislh) < -0.3 || gamepad_button_check(0, gp_padl);
var keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A")) || gpLeft;

var gpDown = gamepad_axis_value(0, gp_axislv) > 0.3 || gamepad_button_check(0, gp_padd);
var keyDown = keyboard_check(vk_down) || keyboard_check(ord("S")) || gpDown;

var gpUp = gamepad_axis_value(0, gp_axislv) < -0.3 || gamepad_button_check(0, gp_padu);
var keyUp = keyboard_check(ord("W")) || keyboard_check(vk_up) || gpUp;

var gpJump = gamepad_button_check_pressed(0, gp_face1);
var keyJump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z")) || gpJump;

var gpJumpHeld = gamepad_button_check(0, gp_face1);
var keyJumpHeld = keyboard_check(vk_space) || keyboard_check(ord("Z")) || gpJumpHeld;

var gpJumpReleased = gamepad_button_check_released(0, gp_face1);
var keyJumpReleased = keyboard_check_released(vk_space) || keyboard_check_released(ord("Z")) || gpJumpReleased;

if (!keyAim)
{
	keyJump |= keyboard_check_pressed(ord("W"));
	keyJump |= keyboard_check_pressed(vk_up);
	keyJumpHeld |= keyboard_check(ord("W"));
	keyJumpHeld |= keyboard_check(vk_up);
	keyJumpReleased |= keyboard_check_released(ord("W"));
	keyJumpReleased |= keyboard_check_released(vk_up);
}

var gpShoot = gamepad_button_check_pressed(0, gp_face3);
var keyShoot = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(ord("X")) || gpShoot;
keyShootHeld = mouse_check_button(mb_left) || keyboard_check(ord("X")) || gamepad_button_check(0, gp_face3);

var keyShootReleased = mouse_check_button_released(mb_left) || keyboard_check_released(ord("X")) || gamepad_button_check_released(0, gp_face3);

var gpAny = gpAim || gpRight || gpLeft || gpDown || gpUp || gpJump || gpJumpHeld || gpJumpReleased || gpShoot;
if (useMouse && gpAny) 
{
	useMouse = false;
}

if (!useMouse && !gpAny && (window_mouse_get_delta_x() != 0 || window_mouse_get_delta_y() != 0))
{
	useMouse = true;
}


if (f1 && !instance_exists(oHackerStone)) activate_hackerstone(self);
if (f2 && !instance_exists(oShieldBubble)) activate_shield(self);


grounded = false;
		
var move = keyRight - keyLeft;
if (move < 0) hsp = max(-walkSpeed, hsp - accel);
if (move > 0) hsp = min(walkSpeed, hsp + accel);
if (move == 0) 
{
	if (sign(hsp) < 0) hsp = min(0, hsp + decel);
	else if (sign(hsp) > 0) hsp = max(0, hsp - decel);
	else hsp = 0;
}
		
vsp += grav;
if (vsp >= maxFallSpeed) vsp = maxFallSpeed;

// Am I on the ground?
if (place_meeting(x, y + 1, oWall)) 
{
	canJump = 5;
	grounded = true;
}

// Am I on the ground?
if (grounded)
{
	isPlanted = false;
	if (keyAim) 
	{
		isPlanted = true;
	}
}
else 
{
	isPlanted = false;
	if (canJump > 0)
	{
		canJump -= 1;
	}
}

if (isPlanted)
{
	move = 0;
	hsp = 0;
}


if (canJump > 0 && keyJump) 
{
	vsp = jumpForce;
}

// Are we going up, but have released jump? Then ease off and start descending
if (vsp < 0 && !keyJumpHeld) 
{
	vsp = max(vsp, (jumpForce/2));
}

if (keyJumpHeld) 
{
	jumpHoldTimer += 1;
}
else
{
	jumpHoldTimer = 0;
}
		
if (move > 0) 
{
	facing = right;
	image_xscale = 1;
}
if (move < 0) 
{
	facing = left;
	image_xscale = -1;
}
		

if (useMouse) 
{
	aimDir = point_direction (hackerStone.x, hackerStone.y, oCursor.x, oCursor.y);
}
else
{
	// Set facing direction
// Default to left and right if no direction held.
	aimDir = facing;
	if ((keyLeft && keyRight) || (keyUp && keyDown)) aimDir = aimDir; // Don't change the aimDir if inputs cancel each other
	else if (keyLeft)
	{
		aimDir = 180;
		if (keyUp) aimDir = 135;
		else if (!grounded && keyDown) aimDir = 225;
	}
	else if (keyRight)
	{
		aimDir = 0;
		if (keyUp) aimDir = 45;
		else if (!grounded && keyDown) aimDir = 315;
	}
	else if (keyUp) aimDir = 90;
	else if (!grounded && keyDown) aimDir = 270;
}

// Horizontal Collisions
if (place_meeting(x + hsp, y, oWall))
{
	var i = abs(hsp);
	while (!place_meeting(x + sign(hsp), y, oWall) && i > 0)
	{
		x += sign(hsp);
		i--;
	}
	hsp = 0;
}
x += hsp;

// Vertical Collisions
if (place_meeting(x, y + vsp, oWall))
{
	var i = abs(vsp);
	while (!place_meeting(x, y + sign(vsp), oWall) && i > 0)
	{
		y += sign(vsp);
		i--;
	}
	vsp = 0;
}
y += vsp;

// Am I on the ground?
if (place_meeting(x, y + 1, oWall)) 
{
	canJump = 5;
	grounded = true;
	if (keyJump || (keyJumpHeld && jumpHoldTimer < 10)) vsp = jumpForce;
}

// Check if we got hit
is_hit();
if (safetyTimer > 0) 
{
	safetyTimer--;
	hit = true;
}

// Move the hackerstone
if (instance_exists(oHackerStone))
{
	var stoneTargetX = x - (12 * sign(image_xscale));
	var stoneTargetY = y - 24;
	hackerStone.x = lerp(hackerStone.x, stoneTargetX, 0.15);
	hackerStone.y = lerp(hackerStone.y, stoneTargetY, 0.15);


	// Handle the shootin'
	if (canShoot && keyShootHeld)
	{
		// This ?? is like a javascript 'nullish' operator, or a ternary statement in C#. If popping yields undefined, create a new bullet
		var bullet = ds_stack_pop(roomManager.bullet1Pool) ?? instance_create_depth(hackerStone.x, hackerStone.y, -100, oBullet1);
	
		with (bullet)
		{ 
			instance_activate_object(self);
			visible = true;
			x = other.hackerStone.x;
			y = other.hackerStone.y;
			roomManager = other.roomManager;
			spd = 8;
			dir = other.aimDir;
			isPlayerOwned = true;
		}
		canShoot = false;
		shotTimer = shotInterval;
		shieldStrength = max(0, shieldStrength - shieldDrain);
	}

	if (!canShoot)
	{
		if (shotTimer > 0) shotTimer -= 1;
		else canShoot = true;
	}

	if (instance_exists(oShieldBubble))
	{
		if (keyShootReleased && !shield.coolDown)
		{
			recoveryTimer = recoveryInterval;
		}
		
		if (!keyShootHeld)
		{
			if (!shield.coolDown)
			{
				if (recoveryTimer > 0)
				{
					recoveryTimer--;
				}
				else 
				{
					shieldStrength = min(100, shieldStrength + shieldRecovery);
				}
			}
		}


		if (!shield.coolDown && shieldStrength <= 0) 
		{
			shield.coolDown = true;
			shield.visible = false;
			shieldCoolDownTimer = shieldCoolDownInterval;
		}
		if (shield.coolDown)
		{
			if (keyShootHeld)
			{
				shield.coolDown = true;
				shield.visible = false;
				shieldCoolDownTimer = shieldCoolDownInterval;
			}
			else if (shieldCoolDownTimer > 0)
			{
				shieldCoolDownTimer -= 1;
			}
			else
			{
				if (!keyShootHeld) 
				{
					with (shield) event_user(0);
				}
			}
		}

		// Handle the shield
		shield.x = x;
		shield.y = y;
	}
}


// Update animation state
if (grounded)
{
	if (hsp != 0)
	{
		sprite_index = sPlayerRun;
		image_xscale = sign(hsp);
	}
	else
	{
		sprite_index = sPlayerIdle;
	}
}
else
{
	sprite_index = sPlayerJumpCrest;
	if (vsp < -1) sprite_index = sPlayerJumpRise;
	if (vsp > 0) sprite_index = sPlayerJumpFall;
}

// Update camera
var viewX = camera_get_view_x(view_camera[0]);
var viewY = camera_get_view_y(view_camera[0]);
var viewWidth = camera_get_view_width(view_camera[0]);
var viewHeight = camera_get_view_height(view_camera[0]);
var lerpX = 0.1;
var lerpY = 0.1;
var goToX = x - (viewWidth * 0.5);
var goToY = y - (viewHeight * 0.5);

// Mouse aim stuff
if (useMouse && !isMouseAiming && mouse_check_button(mb_right))
{
	isMouseAiming = true;
	mouseAimStartX = oCursor.x;
	mouseAimStartY = oCursor.y;
}
else if (isMouseAiming && mouse_check_button(mb_right))
{
	var deltaX = clamp(oCursor.x - mouseAimStartX, -1, 1);
	var deltaY = clamp(oCursor.y - mouseAimStartY, -1, 1);
	
	goToX = x + ((deltaX) * 150) - (viewWidth * 0.5);
	lerpX = 0.025;

	if (isPlanted) 
	{
		goToY = y + ((deltaY) * 150) - (viewHeight * 0.5);
		lerpY = 0.05;
	}
}
else
{
	isMouseAiming = false;
	goToX = x + ((keyRight - keyLeft) * 150) - (viewWidth * 0.5);
	lerpX = 0.025;

	if (isPlanted) 
	{
		goToY = y + ((keyDown - keyUp) * 150) - (viewHeight * 0.5);
		lerpY = 0.05;
	}

}
adjCamX = lerp(viewX, goToX, lerpX);
adjCamY = lerp(viewY, goToY, lerpY);


if (camZoom > 1)
{
	camZoom = lerp(camZoom, 1, camZoomFactor);
}


if (roomBounds != noone)
{	
	var lerpHeight = lerp(viewHeight, camZoom * oCamera.camHeight, camZoomFactor);
	var newHeight = clamp(lerpHeight, 0, room_height);
	var newWidth = newHeight * (oCamera.camWidth / oCamera.camHeight);
	camera_set_view_size(view_camera[0], round(newWidth), round(newHeight));

	var offsetX = adjCamX - (newWidth - viewWidth) * 0.5;
	var offsetY = adjCamY - (newHeight - viewHeight) * 0.5;
	
	adjCamX = clamp(offsetX, roomBounds.x, (roomBounds.x + roomBounds.width) - newWidth);
	adjCamY = clamp(offsetY, roomBounds.y, (roomBounds.y + roomBounds.height) - newHeight);
}
else
{
	var lerpHeight = lerp(viewHeight, camZoom * oCamera.camHeight, camZoomFactor);
	var newHeight = clamp(lerpHeight, 0, room_height);
	var newWidth = newHeight * (oCamera.camWidth / oCamera.camHeight);
	camera_set_view_size(view_camera[0], round(newWidth), round(newHeight));

	var offsetX = adjCamX - (newWidth - viewWidth) * 0.5;
	var offsetY = adjCamY - (newHeight - viewHeight) * 0.5;
	
	adjCamX = clamp(offsetX, 0, room_width - newWidth);
	adjCamY = clamp(offsetY, 0, room_height - newHeight);
}

camera_set_view_pos(view_camera[0], round(adjCamX), round(adjCamY));