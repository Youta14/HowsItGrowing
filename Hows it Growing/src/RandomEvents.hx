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
	
	var randomEvent:Int = 0;
	var maybeWind:Int = 0;
	var wD:Int = 0;
	
	var plant:Plant;
	
	
	public function new(_plant:Plant) 
	{
		super();
		plant = _plant;
	}
	
	public function pickEvent()
	{
		randomEvent = Std.random(5);
		switch (randomEvent) 
		{
			case 1:
				rain = true;
				wind();				
			case 2:
				heat = true;
				wind();
			case 3:
				wind();
			case 4:
				plant.aphidAmount = 1;
			default:
				rain = false;
				heat = false;
				windSpeed = 0;
		}
		trace(randomEvent);
	}
	
	function wind()
	{
		wD = Std.random(2); //selecting wind direction(wD)
		if (wD == 1) 
		{
			windDirection = true; //true == left
		} else 
		{
			windDirection = false; //false == false
		}
		
		maybeWind = Std.random(6); //
		if (maybeWind >= 3) 
		{
			windSpeed = Std.random(10);
		}
	}
	
	public function aphids()
	{
		while (plant.aphidAmount>0) 
		{
			//display amount of aphids
			plant.aphidAmount += Math.ceil(0.5 *plant.aphidAmount);
		}
	}
	
	public override function waterState() //function to override the water the plant needs during rain and heat
	{
		if (rain = true)
		{
			//load rain animation
			waterModifier = 0;
		}
		else
		{
			//reset to default weather animation
			waterModifier = waterModifier + 1;
		}
		
		if (heat = true)
		{
			//load heat animation
			waterModifier = waterModifier + 2;
		}
		else
		{
			//reset to default weather animation
			waterModifier = waterModifier + 1;
		}
	}
}