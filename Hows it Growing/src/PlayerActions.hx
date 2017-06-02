package src;

/**
 * ...
 * @author Sander Hiemstra
 */
class PlayerActions 
{
	var bees:Bool = false;
	
	public function new() 
	{
		
	}
	
	function prune()
	{
		//remove a branch, adjust balance modifier
	}
	
	function water()
	{
		Plant.waterModifier = Plant.waterModifier - 5;
	}
	
	function bees()
	{
		if (bees = true) 
		{
			Plant.maxStability = Plant.maxStability + 5;
		}
		
		//when bees leave
		Plant.maxStability = Plant.maxStability - 5;
	}
	
	function ladybugs()
	{
		Plant.aphidAmount = Plant.aphidAmount - 2;
		//way to keep doing for multiple turns
	}
	
	function pesticides()
	{
		//remove pesticides, decreace plant stability, remove animals
		Plant.aphidAmount = 0;
		Plant.currenctStability = Plant.currecntStability - 3;
	}
	
	function stick()
	{
		Plant.maxStability = Plant.maxStability + 3;
		//turns done = 5
		Plant.maxStability = Plant.maxStability - 3:
	}
}                        