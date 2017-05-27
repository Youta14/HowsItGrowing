package src;
import openfl.display.Sprite;

/**
 * ...
 * @author cunt
 */
class Branch extends Sprite
{
	public var rootNode:Int;
	public var branchPath:Array<Bool> = new Array();
	public var canUp:Bool;
	public var canDown:Bool;
	
	public function new() 
	{
		super();
		
		canUp = true;
		canDown = true;
	}
}