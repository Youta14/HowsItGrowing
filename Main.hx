package;

import Math;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import src.Plant;

/**
 * ...
 * @author cunt
 */
class Main extends Sprite 
{
	var plant:Plant;
	var text:Text;
	
	var count:Int = 0;
	var stemCount:Int = 0;
	
	public function new() 
	{
		super();
		
		plant = new Plant();
		addChild(plant);
		
		text = new Text();
		addChild(text);
		
		this.addEventListener(Event.ENTER_FRAME, Update);
		
		var float:Float = (Math.cos(37) * 20);
		
		var string:String = ("penis " + float);
		text.updateText(string);
	}
	
	public function Update(ev:Event)
	{
		if (++count >= 30)
		{
			for (x in 0 ... Std.random(3) + 1)
				plant.growBranch();
				
			count = 0;
			
			if (++stemCount >= 5)
			{
				if(plant.numStems < 10)
					plant.growStem();
					
				stemCount = 0;
			}
		}
	}
}
