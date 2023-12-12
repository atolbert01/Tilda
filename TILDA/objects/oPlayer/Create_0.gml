event_inherited();
//enum PlayerState
//{
//	Normal,
//	Zip,
//	Knocked,
//}
//state = PlayerState.Normal;

hsp = 0;
vsp = 0;
height = bbox_bottom - bbox_top;
halfWidth = (bbox_right - bbox_left) * 0.5;
//terrain = layer_tilemap_get_id(layer_get_id("Terrain"));

grav = 0.3;
maxFallSpeed = 10;
walkSpeed = 3;
jumpForce = -6;
canJump = 0;
jumpHoldTimer = 0;
grounded = false;
aimDir = 0;
left = 180;
right = 0;
facing = right;
isPlanted = false;
isShooting = false;

center_y = function()
{
	return y - (height * 0.5);
}

accel = 1.0;
decel = 1.0;


adjCamX = camera_get_view_x(view_camera[0]);
adjCamY = camera_get_view_y(view_camera[0]);
camZoom = 1;
camZoomFactor = 0.2;

//currentRoomManager = undefined;

hackerStone = instance_create_depth(x, y - 24, -50, oHackerStone);
hackerStone.image_speed = 0.4;
instance_deactivate_object(hackerStone);

shield = instance_create_depth(x, y, -25, oShieldBubble);
shieldStrength = 0;
shieldDrain = 1;
shieldRecovery = 0.75;
shieldCoolDownInterval = 600;
shieldCoolDownTimer = 0;
instance_deactivate_object(oShieldBubble);

hackerMode = oHackerMode;


canShoot = true;
keyShootHeld = false;
shotInterval = 8;
shotTimer = 0;

roomManager = oRoomManager;

useMouse = true;
mouseAimStartX = 0;
mouseAimStartY = 0; 
isMouseAiming = false;
glitchBudget = 0;

roomBounds = noone;
