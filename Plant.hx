package src;

import Math;

import openfl.Assets;
import openfl.display.Sprite;

import openfl.Vector;

/**
 * ...
 * @author cunt
 */
class Plant extends Sprite
{
	var stems:Array<Stem> = new Array();
	public var numStems:Int = 0;
	var branches:Array<Branch> = new Array();
	var numBranches:Int = 0;

	public function new() 
	{
		super();
		
		/*branches[0] = new Branch(stem[0].x + stem[0].width, stem[0].y + stem[0].height / 2, false);
		addChild(branches[0]);*/
	}
	
	private function calcPossibleBranches():Int
	{
		var possibleBranches:Int = 0;
		for (stm in stems)
		{
			if (stm.upLeft || stm.downLeft)
				possibleBranches++;
			if (stm.upRight || stm.downRight)
				possibleBranches++;
		}
		for (branch in branches)
		{
			if (branch.canUp || branch.canDown)
				possibleBranches++;
		}
		
		return possibleBranches;
	}
	public function growBranch()
	{
		var select:Int = Std.random(calcPossibleBranches()) + 1;
		var count:Int = 0;
		
		for (x in 0 ... numStems)
		{
			if (stems[x].upLeft || stems[x].downLeft)
			{
				if (++count == select)
					addBranchStem(x, true);
			}
			if (stems[x].upRight || stems[x].downRight)
			{
				if (++count == select)
					addBranchStem(x, false);
			}
		}
		for (x in 0 ... numBranches)
		{
			if (branches[x].canUp || branches[x].canDown)
			{
				if (++count == select)
					addBranchBranch(x);
			}
		}
	}
	private function addBranchStem(x:Int, leftRight:Bool)
	{	
		if (leftRight)
		{
			if (stems[x].upLeft && stems[x].downLeft)
			{
				branches[numBranches] = new Branch(stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0);
					
				if (branches[numBranches].upDown)
					stems[x].upLeft = false;
				else
					stems[x].downLeft = false;
			}
			else if (stems[x].upLeft && !stems[x].downLeft)
			{
				branches[numBranches] = new Branch(stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0, true);
				
				stems[x].upLeft = false;
			}
			else if (!stems[x].upLeft && stems[x].downLeft)
			{
				branches[numBranches] = new Branch(stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0, false);
					
				stems[x].downLeft = false;
			}
		}
		else
		{
			if (stems[x].upRight && stems[x].downRight)
			{
				branches[numBranches] = new Branch(stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0);
					
				if (branches[numBranches].upDown)
					stems[x].upRight = false;
				else
					stems[x].downRight = false;
			}
			else if (stems[x].upRight && !stems[x].downRight)
			{
				branches[numBranches] = new Branch(stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0, true);
					
				stems[x].upRight = false;
			}
			else if (!stems[x].upRight && stems[x].downRight)
			{
				branches[numBranches] = new Branch(stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0, false);
					
				stems[x].downRight = false;
			}
		}
		
		addChild(branches[numBranches]);
		numBranches++;
	}
	private function addBranchBranch(x:Int)
	{
		var xPos:Float = 0;
		var yPos:Float = 0;
		
		var angle:Float = (40 - branches[x].weight * 10) * (3.141592653 / 180);
		
		if (branches[x].leftRight)
			xPos = branches[x].x - (Math.cos(angle) * 20);
		else
			xPos = branches[x].x + (Math.cos(angle) * 20);
		if (branches[x].upDown)
			yPos = branches[x].y - (Math.sin(angle) * 20);
		else
			yPos = branches[x].y + (Math.sin(angle) * 20);
		
		if (branches[x].canUp && branches[x].canDown)
		{
			branches[numBranches] = new Branch(xPos, yPos, branches[x].leftRight, branches[x].weight);
			
			if (branches[numBranches].upDown)
				branches[x].canUp = false;
			else
				branches[x].canDown = false;
		}
		else if (branches[x].canUp && !branches[x].canDown)
		{
			branches[numBranches] = new Branch(xPos, yPos, branches[x].leftRight, branches[x].weight, true);
			branches[x].canUp = false;
		}
		else if (!branches[x].canUp && branches[x].canDown)
		{
			branches[numBranches] = new Branch(xPos, yPos, branches[x].leftRight, branches[x].weight, false);
			branches[x].canDown = false;
		}
		
		addChild(branches[numBranches]);
		numBranches++;
	}
	public function growStem()
	{
		if (numStems == 0)
			stems[numStems] = new Stem();
		else
			stems[numStems] = new Stem(stems[numStems - 1].y - 50);
		
		addChild(stems[numStems]);
		numStems++;
	}
}