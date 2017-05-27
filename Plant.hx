package src;

import flash.display.GraphicsGradientFill;
import openfl.Assets;
import openfl.display.Sprite;

import openfl.Vector;

/**
 * ...
 * @author cunt
 */
class Plant extends Sprite
{
	var stem:Array<Sprite> = new Array();
	var branches:Array<Branch> = new Array();
	var rootNodes:Array<Bool> = new Array();
	
	//variables for watermodifier
	var waterModifier:Int;
	var balanceModifier:Int;
	
	//variables for plant stability
	var currentStability:Int;
	var maxStability:Int;
	
	//variables for aphids
	var aphidAmount:Int;
	
	public function new() 
	{
		super();
		
		var yPos:Int = 600;
		for (x in 0 ... 5)
		{
			stem[x] = new Sprite();
			stem[x].graphics.beginFill(0x9E4F0E);
			stem[x].graphics.drawRect(265, yPos, 10, 50);
			stem[x].graphics.endFill();
			addChild(stem[x]);
			yPos -= 52;
		}
	}
	
	public function calcPossibleBranches():Int
	{
		var possibleBranches:Int = 0;
		for (node in rootNodes)
		{
			if (node)
				possibleBranches++;
		}
		for (branch in branches)
		{
			if (branch.canUp || branch.canDown)
				possibleBranches++;
		}
		
		return possibleBranches;
	}
	
	public function waterState()
	{
		waterModifier = waterModifier + 1;
	}
}