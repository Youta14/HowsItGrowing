package src;

/**
 * ...
 * @author Sander Hiemstra
 */
class RandomEvents 
{
	var aphidCount:Int;
	var rain:Bool;
	var heat:Bool;
	var windSpeed:Int;
	var windDirection:Bool;
	
	var randomEvent:Int;
	public function new() 
	{
		
	}
	
	public function pickEvent()
	{
		randomEv = Std.random(6);
		switch (randomEvent)
			case 1:
				rain = true;
			case 2:
				heat = true;
			case 3:
				windSpeed = Std.random(10);
			case 4:
				windDirection = true; //left or right thing?
			case 5:
				rain = false;
				heat = false;
				windSpeed = 0;
				windDirection = false;
	}
	
	function turnUpdate()
	{
		
	}
}