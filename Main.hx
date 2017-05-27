package;

import openfl.display.Sprite;
import openfl.Lib;
import src.Plant;

import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author cunt
 */
class Main extends Sprite 
{
	var plant:Plant;
	var text:Text;
	
	public function new() 
	{
		super();
		
		plant = new Plant();
		addChild(plant);
		
		text = new Text();
		addChild(text);
		
		var string:String = ("Branches " + plant.calcPossibleBranches());
		text.updateText(string);
	}
}
