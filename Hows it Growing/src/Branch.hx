package src;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author cunt
 */
class Branch extends Sprite
{
	var plant:Plant;
	
	public var ID:Int;
	public var rootNode:Int;
	public var branchPath:Array<Bool> = new Array();
	public var lengthBP:Int;
	public var weight:Int;
	
	public var branchWidth:Float = 23.62;
	public var branchHeight:Float = 70.86;
	
	public var canUp:Bool;
	public var canDown:Bool;
	
	public var upDown:Bool;
	public var leftRight:Bool;
	
	var bitmap:Bitmap;
	var	bitmapData:BitmapData;
	
	var rect:Sprite;
	
	public function new(_plant:Plant, branchID:Int, x:Float, y:Float, stemSide:Bool, prevWeight:Int, ?hiLo:Bool, ?prevBP:Array<Bool>)
	{
		super();
		
		plant = _plant;
		
		ID = branchID;
		
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
			
		if (prevBP != null)
			branchPath = prevBP;
		branchPath.push(upDown);
		
		rect = new Sprite();
		rect.graphics.beginFill(0xBC5F29, 1);
		rect.graphics.drawRect(0, 0, 5, 75);
		rect.graphics.endFill();
		addChild(rect);
		
		rect.addEventListener(MouseEvent.MOUSE_DOWN, remove);
		
		this.x = x;
		this.y = y;		
		
		var rotationMod:Int = prevWeight * 5;
		rotationMod = 0;	//get rid off to add back converging angle
		
		if (leftRight && upDown)
		{
			this.rotation -= rotationMod;
			this.x -= branchWidth;
			this.y -= branchHeight;
			
			rect.rotation = 342;
			
			bitmapData = Assets.getBitmapData("img/Right_Down_To_Left_Up.png");
		}
		else if (leftRight && !upDown)
		{
			this.rotation += rotationMod;
			this.x -= branchWidth;
			
			rect.x += branchWidth;
			rect.rotation = 18;
			
			bitmapData = Assets.getBitmapData("img/Right_Up_To_Down_Left.png");
		}
		else if (!leftRight && upDown)
		{
			this.rotation += rotationMod;
			this.y -= branchHeight;
			
			rect.x += branchWidth;
			rect.rotation = 18;
			
			bitmapData = Assets.getBitmapData("img/Left_Down_To_Right_Up.png");
		}
		else
		{
			this.rotation -= rotationMod;
			
			rect.rotation = 342;
			
			bitmapData = Assets.getBitmapData("img/Left_Up_To_Right_Down.png");
		}
		
		bitmap = new Bitmap(bitmapData);
		bitmap.scaleX = 0.01;
		bitmap.scaleY = 0.01;
		addChild(bitmap);
	}
	
	private function remove(ev:Event)
	{
		removeEventListener(MouseEvent.MOUSE_DOWN, remove);
		removeChild(bitmap);
		removeChild(rect);
		plant.removeBranch(this);
	}
	public function removeExtra()
	{
		removeEventListener(MouseEvent.MOUSE_DOWN, remove);
		removeChild(bitmap);
		removeChild(rect);
	}
}