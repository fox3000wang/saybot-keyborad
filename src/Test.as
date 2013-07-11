package
{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width="1024", height="768", nodeRate="24", backgroundColor="#DDDDDD")]
	public class Test extends Sprite
	{
		public function Test()
		{
			var tf:TextFormat = new TextFormat;
			
			
			var t:TextField = new TextField();
			addChild(t);
			t.width = 1024;
			
			//t.textWidth = 1024;
			
			
			var keyBoard:KeyBoard = new KeyBoard();
			keyBoard.Target = t;
			this.addChild(keyBoard);
			keyBoard.x = keyBoard.y = 100;
			
			
			keyBoard.scaleX = keyBoard.scaleY = 2;
		}
	}
	
}