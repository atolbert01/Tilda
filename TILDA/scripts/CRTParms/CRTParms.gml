function CRTParameters() constructor
{
	enum ECRT
	{
		ResX,
		ResY,
		ResScale,
		HardScan,
		HardPixel,
		WarpX,
		WarpY,  
		MaskDark,
		MaskLight,
		SRGB,
		Last
	}
	
	// Some default values that look decent            Scale  Scan  Pixel  WarpX  WarpY  Dark  Light  SRGB
	Params = [window_get_width(), window_get_height(), 4.0,   -8.0, -3.0,  32.0,  24.0,  0.5,  1.5,   1];
	ShaderOn = true;
	
	function Set(_resX, _resY, _resScale, _scan, _pixel, _warpX, _warpY, _dark, _light, _srgb)
	{
		Params = 
		[
			_resX,
			_resY,
			clamp(_resScale, 2, 6),
			clamp(_scan, -8, -16),
			clamp(_pixel,-2, -4),
			clamp(_warpX, 0, 32),
			clamp(_warpY, 0, 24),
			clamp(_dark,  0.2, 2),
			clamp(_light, 0.2, 2),
			_srgb
		];
	}
	
	function SetResolution(_resX, _resY)
	{
		Params[ECRT.ResX] = _resX;
		Params[ECRT.ResY] = _resY;
	}
}

//function GameStateCreate() constructor
//{
//	Name    = "CRT Shader";
//	Version = "0.0.0.1";
	
//	CRT = new CRTParameters();
//}