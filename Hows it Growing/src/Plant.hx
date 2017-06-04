package src;

import Math;

import openfl.Assets;
import openfl.display.Sprite;

import openfl.events.Event;

import openfl.Vector;

/**
 * ...
 * @author cunt
 */
class Plant extends Sprite
{
	var stems:Array<Stem> = new Array();
	public var numStems:Int = 0;
	public var branches:Array<Branch> = new Array();
	public var numBranches:Int = 0;
	
	//variables for watermodifier
	var waterModifier:Int;
	var balanceModifier:Int;
	
	//variables for plant stability
	var currentStability:Int;
	var maxStability:Int;
	
	//variables for aphids
	public var aphidAmount:Int = 0;

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
				branches[numBranches] = new Branch(this, numBranches, stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0);
					
				if (branches[numBranches].upDown)
					stems[x].upLeft = false;
				else
					stems[x].downLeft = false;
			}
			else if (stems[x].upLeft && !stems[x].downLeft)
			{
				branches[numBranches] = new Branch(this, numBranches, stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0, true);
				
				stems[x].upLeft = false;
			}
			else if (!stems[x].upLeft && stems[x].downLeft)
			{
				branches[numBranches] = new Branch(this, numBranches, stems[x].x, 
					stems[x].y + stems[x].height / 2, leftRight, 0, false);
					
				stems[x].downLeft = false;
			}
			branches[numBranches].rootNode = x * 2;
		}
		else
		{
			if (stems[x].upRight && stems[x].downRight)
			{
				branches[numBranches] = new Branch(this, numBranches, stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0);
					
				if (branches[numBranches].upDown)
					stems[x].upRight = false;
				else
					stems[x].downRight = false;
			}
			else if (stems[x].upRight && !stems[x].downRight)
			{
				branches[numBranches] = new Branch(this, numBranches, stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0, true);
					
				stems[x].upRight = false;
			}
			else if (!stems[x].upRight && stems[x].downRight)
			{
				branches[numBranches] = new Branch(this, numBranches, stems[x].x + stems[x].width, 
					stems[x].y + stems[x].height / 2, leftRight, 0, false);
					
				stems[x].downRight = false;
			}
			branches[numBranches].rootNode = (x * 2) + 1;
		}
		
		branches[numBranches].lengthBP = 1;
		addChild(branches[numBranches]);
		numBranches++;
	}
	private function addBranchBranch(x:Int)
	{
		var xPos:Float = 0;
		var yPos:Float = 0;
		
		var angle:Float = (branches[x].weight * 5) * (3.141592653 / 180);
		
		if (branches[x].leftRight)
			xPos = branches[x].x;// - (Math.cos(angle) * 20);
		else
			xPos = branches[x].x + branches[x].branchWidth;// + (Math.cos(angle) * 20);
		if (branches[x].upDown)
			yPos = branches[x].y;// - (Math.sin(angle) * 20);
		else
			yPos = branches[x].y + branches[x].branchHeight;// + (Math.sin(angle) * 20);
		
		if (branches[x].canUp && branches[x].canDown)
		{
			branches[numBranches] = new Branch(this, numBranches, xPos, yPos, 
				branches[x].leftRight, branches[x].weight, null, branches[x].branchPath);
			
			if (branches[numBranches].upDown)
				branches[x].canUp = false;
			else
				branches[x].canDown = false;
		}
		else if (branches[x].canUp && !branches[x].canDown)
		{
			branches[numBranches] = new Branch(this, numBranches, xPos, yPos, 
				branches[x].leftRight, branches[x].weight, true, branches[x].branchPath);
				
			branches[x].canUp = false;
		}
		else if (!branches[x].canUp && branches[x].canDown)
		{
			branches[numBranches] = new Branch(this, numBranches, xPos, yPos, 
				branches[x].leftRight, branches[x].weight, false, branches[x].branchPath);
				
			branches[x].canDown = false;
		}
		
		branches[numBranches].rootNode = branches[x].rootNode;
		branches[numBranches].lengthBP = branches[x].lengthBP + 1;
		addChild(branches[numBranches]);
		numBranches++;
	}
	public function removeBranch(branch:Branch)		//Need to reset root and branch bools e.g. canUp upLeft etc
	{
		branches.remove(branch);
		numBranches--;
			
		var extraBranches:Array<Int> = new Array();
		var modifier:Int = 0;
		for (x in 0 ... numBranches)
		{
			if (branches[x].rootNode == branch.rootNode)
			{
				var count:Int = 0;
				for (y in 0 ... branch.lengthBP)
				{
					if (branches[x].branchPath[y] == branch.branchPath[y])
						count++;
				}
				if (branch.lengthBP <= count && branch.lengthBP < branches[x].lengthBP)
				{
					extraBranches.push(x - modifier);
					modifier++;
				}
				else if (branch.lengthBP == 1)
				{
					var stemPiece:Int = Math.floor(branch.rootNode / 2);
					if (branch.leftRight && branch.upDown)
						stems[stemPiece].upLeft = true;
					else if (branch.leftRight && !branch.upDown)
						stems[stemPiece].downLeft = true;
					else if (!branch.leftRight && branch.upDown)
						stems[stemPiece].upRight = true;
					else
						stems[stemPiece].downRight = true;
				}
				else if (branch.lengthBP == count - 1 && branch.lengthBP == branches[x].lengthBP - 1)
				{
					if (branch.upDown)
						branches[x].canUp = true;
					else
						branches[x].canDown = true;
				}
			}
		}
		
		for (x in 0 ... extraBranches.length)
		{
			branches[extraBranches[x]].removeExtra();
			branches.remove(branches[extraBranches[x]]);
			numBranches--;
		}
	}
	
	public function growStem()
	{
		if (numStems == 0)
			stems[numStems] = new Stem();
		else
			stems[numStems] = new Stem(stems[numStems - 1].y - 100);
		
		addChild(stems[numStems]);
		numStems++;
	}
	
	public function waterState()
	{
		waterModifier = waterModifier + 1;
	}
}