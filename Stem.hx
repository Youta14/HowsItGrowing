package src;

import openfl.display.Sprite;

/**
 * ...
 * @author cunt
 */
class Stem extends Sprite
{
	var rect:Sprite;
	public var upLeft:Bool = true;
	public var upRight:Bool = true;
	public var downLeft:Bool = true;
	public var downRight:Bool = true;
	
	public function new(?yPos:Float) 
	{
		super();
		
		rect = new Sprite();
		rect.graphics.beginFill(0x9E4F0E);
		rect.graphics.drawRoundRect(0, 0, 10, 50, 20);
		rect.graphics.endFill();
		addChild(rect);
		
		this.x = 265;
		if (yPos == null)
			this.y = 600;
		else
			this.y = yPos;
	}
}