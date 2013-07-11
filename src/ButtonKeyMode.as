package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	* infor  : 按键类
	* Author : Anonymous
	* Date   : 2012.06.13
	*/
	public class ButtonKeyMode extends MovieClip {
		[Embed(source = "/Keyborad.swf", symbol="ButtonKeyMode")]
		private static const clazz:Class;

		private var _mc:MovieClip;
		private var _key:TextField;
		private var _keyValue:String;
		private var _keyWidth:Number;

		private var isShift:Boolean=true;//上档键类型
		private var isLetter:Boolean=true;//字母键类型
		private var isClicked:Boolean=false;

		/**
		 *构造函数
		 */
		public function ButtonKeyMode() {
			//_mc=this;
			_mc=new clazz;
			this.addChild(_mc);
			
			_key=_mc.getChildByName("txt_KeyName") as TextField;
			_mc.stop();
			_mc.buttonMode=true;
			_mc.mouseChildren =false;
			_mc.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHd);
			_mc.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHd);
			_mc.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHd);
		}
		
		/**
		*@宽度
		*/
		public function set KeyWidth(value:Number):void {
			_mc.width=value;
		}
		public function get KeyWidth():Number {
			return _mc.width;
		}
		
		/**
		*@按键值
		*/
		public function get KeyValue():String {
			return _keyValue;
		}
		public function set KeyValue(value:String):void {
			_keyValue=value;
			_key.text=_keyValue;
			_keyWidth=_key.textWidth;
		}
		
		/**
		*@上档键属性
		*/
		public function set ShiftKey(value:Boolean):void {
			isShift=value;
		}
		public function get ShiftKey():Boolean {
			return isShift;
		}
		
		/**
		*@字母键
		*/
		public function set LetterKey(value:Boolean):void {
			isLetter=value;
		}
		public function get LetterKey():Boolean {
			return isLetter;
		}


		public function Clicked():void {
			isClicked=!isClicked;
			if (isClicked) {
				_mc.gotoAndStop(3);
			} else {
				_mc.gotoAndStop(1);
			}
		}
		private function onMouseOverHd(e:MouseEvent):void {
			if (!isClicked) {
				_mc.gotoAndStop(2);
			}
		}
		private function onMouseOutHd(e:MouseEvent):void {
			if (!isClicked) {
				_mc.gotoAndStop(1);
			}
		}
		private function onMouseDownHd(e:MouseEvent):void {
			if (!isClicked) {
				_mc.gotoAndStop(3);
			}
		}
	}
}