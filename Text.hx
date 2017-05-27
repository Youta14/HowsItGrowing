package;

import openfl.Assets;
import openfl.display.Sprite;

import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;
/**
 * ...
 * @author cunt
 */
class Text extends Sprite
{
	var textField:TextField;
	
	public function new() 
	{
		super();
		
		var font:Font = Assets.getFont("fonts/arial.ttf");
		
		var textFormat:TextFormat = new TextFormat(font.fontName, 20,
		0xFFFFFF);
		
		textField = new TextField();
		textField.autoSize = openfl.text.TextFieldAutoSize.LEFT;
		textField.embedFonts = true;
		textField.selectable = false;
		textField.defaultTextFormat = textFormat;
		textField.height = 200;
		
		addChild(textField);
	}
	
	public function updateText(text:String)
	{
		textField.text = text;
	}
}