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
	public var weight:Int;
	
	public var canUp:Bool;
	public var canDown:Bool;
	
	public var upDown:Bool;
	public var leftRight:Bool;
	
	var rect:Sprite;
	
	public function new(x:Float, y:Float, stemSide:Bool, prevWeight:Int, ?hiLo:Bool)
	{
		super();
		
		weight = prevWeight + 1;
		
		canUp = true;
		canDown = true;
		
		leftRight = stemSide;
		if (hiLo == null)
		{
			var select = Std.random(2);
			if (select == 0)
				upDown = true;
			else if (select == 1)
				upDown = false;
		}
		else
			upDown = hiLo;
		
		
		rect = new Sprite();
		rect.graphics.beginFill(0xBC5F29);
		rect.graphics.drawRect(0, 0, 1, 20);
		rect.graphics.drawRect(0, 18, 3, 4);
		rect.graphics.endFill();
		addChild(rect);
		
		this.x = x;
		this.y = y;		
		
		var rotationMod:Int = prevWeight * 10;
		
		if (leftRight && upDown)
			this.rotation = 130 - rotationMod;
		else if (leftRight && !upDown)
			this.rotation = 50 + rotationMod;
		else if (!leftRight && upDown)
			this.rotation = 230 + rotationMod;
		else
			this.rotation = 310 - rotationMod;
	}
}