package src;

import Math;

/**
 * ...
 * @author Sander Hiemstra
 */
class RandomEvents extends Plant
{
	var aphidCount:Int = 0;
	var rain:Bool = false;
	var heat:Bool = false;
	var windSpeed:Int = 0;
	var windDirection:Bool = false;
	
	var randomEvent:Int;
	var maybeWind:Int;
	var wD:Int;
	
	var plant:Plant;

	
	public function new(_plant:Plant) 
	{
		plant = _plant;
	}
	
	public function pickEvent()
	{
		randomEv = Std.random(5);
		switch (randomEvent)
			case 1:
				rain = true;
				wind();				
			case 2:
				heat = true;
				wind();
			case 3:
				wind();
			case 4:
				Plant.aphidAmount = 1;
			default:
				rain = false;
				heat = false;
				windSpeed = 0;
	}
	
	function wind()
	{
		wD = Std.random(2);
		if (wD == 1) 
		{
			windDirection = true; //true == left
		} else 
		{
			windDirection = false; //false == false
		}
		
		maybeWind = Std.random(6);
		if (maybeWind => 5) 
		{
			windSpeed = Std.random(10);
			selectingWindDirection();
		}
	}
	
	public function aphids()
	{
		while (plant.aphidAmount>0) 
		{
			plant.aphidAmount += Math.ceil(0.5 *plant.aphidAmount);
		}
	}
	
	function rain()
	{
		//making it raaaain
		
	}
	
	function heat()
	{
		//scorch the mothertrucker
	}
}
