package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	* infor  : 软键盘类
	* Author : Anonymous
	* Date   : 2012.06.13
	* Code   : import com.KeyBoard;var bd:KeyBoard=new KeyBoard;addChild(bd);bd.Target=tt;
	*/
	public class KeyBoard extends MovieClip {
		[Embed(source = "/Keyborad.swf", symbol="KeyBoard")]
		private static const clazz:Class;

		
		private var _target:TextField;
		private var keyArray:Array=[];
		private var keyNameArray:Array=new Array(
		 ["`","1","2","3","4","5","6","7","8","9","0","-","=","Backspace"],
		 ["Tab","q","w","e","r","t","y","u","i","o","p","[","]","\\"],
		 ["Lock","a","s","d","f","g","h","j","k","l",";","'","Enter","null"],
		 ["Shift","z","x","c","v","b","n","m",",",".","/"," ","null","null"]
		 );
		private var shiftKeyNameArray:Array=new Array("~","!","@","#","$","%","^","&","*","(",")","_","+","{","}","|",":","\"","<",">","?");
		private var _isLock:Boolean=false;
		private var _isShift:Boolean=false;
		private var xOff:Number=10;
		private var xSplit:Number=1;
		private var yOff:Number=20;
		private var ySplit:Number=1;
		private var keyWidth:Number=20;
		private var myTextFormat:TextFormat;

		/*
		* @ 设置文本框对象
		*/
		public function set Target(txt:TextField):void {
			_target=txt;
			myTextFormat=_target.getTextFormat();
		}

		public function KeyBoard() {
			init();
		}

		private function init():void {
			addChild(new clazz);
			myTextFormat=new TextFormat ;
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHd);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHd);
			crreateKey();
		}
		//创建按键
		private function crreateKey():void {
			for (var i:int=0; i < keyNameArray.length; i++) {
				for (var j:int=0; j < keyNameArray[0].length; j++) {
					if (keyNameArray[i][j] != "null") {
						var temp:ButtonKeyMode=new ButtonKeyMode;
						temp.KeyValue=keyNameArray[i][j];
						temp.name="KeyName_" + i + "_" + j;
						closeLetterKey(temp,i,j);
						closeShiftKey(temp,i,j);
						temp.KeyWidth=setKeyWidth(i,j);
						keyArray.push(temp);
					} else {
						var emp:MovieClip=new MovieClip;
						emp.name="null";
						keyArray.push(emp);
					}
				}
			}
			locatoinKey();
		}
		
		//定位按键
		private function locatoinKey():void {
			for (var i:int=0; i < keyArray.length; i++) {
				var temp:*=keyArray[i];
				if (0 == i % 14) {
					temp.x=0 + xOff;
				} else {
					temp.x=xSplit + keyArray[i - 1].x + keyArray[i - 1].width;
				}
				addChild(temp);
				//temp.y=yOff + int(i / 14) * temp.height + ySplit;
				temp.y=yOff + int(i / 14) * (temp.height + 1);
				temp.addEventListener(MouseEvent.CLICK, onClickHd);
			}
		}
		
		private function onMouseDownHd(e:MouseEvent):void {
			this.startDrag();
		}
		private function onMouseUpHd(e:MouseEvent):void {
			this.stopDrag();
		}

		//输入模式
		private function onClickHd(e:MouseEvent):void {

			if ("Backspace" == e.currentTarget.KeyValue) {//回格键
				var tt:*=_target.text;
				tt=tt.substr(0,tt.length - 1);
				_target.text=tt;
			} else if ("Tab" == e.currentTarget.KeyValue) {//Tab键
			} else if ("Lock" == e.currentTarget.KeyValue) {//Lock键
				lockKeyMode();
				e.currentTarget.Clicked();
			} else if ("Enter" == e.currentTarget.KeyValue) {//回车键
			} else if ("Shift" == e.currentTarget.KeyValue) {//两个shift键
				shiftKeyMode();
				var temp_key1:ButtonKeyMode;
				temp_key1=this.getChildByName("KeyName_3_0")  as  ButtonKeyMode;
				temp_key1.Clicked();
//				var temp_key2:ButtonKeyMode;
//				temp_key2=this.getChildByName("KeyName_3_11")  as  ButtonKeyMode;
//				temp_key2.Clicked();
			} else {//非功能键
				_target.setTextFormat(myTextFormat);
				_target.appendText(e.currentTarget.KeyValue);
			}
		}
		
		//设置按键的宽度
		private function setKeyWidth(i:Number,j:Number):Number {
			var _w:Number;
			var _temp:Number;
			if (0 == i && 13 == j) {//回格键没有
				_w=keyWidth * 2;
			} else if (1 == i && 0 == j) {//Tab键
				_temp=1 + 3 / 4;
				_w=keyWidth * _temp;
			} else if (1 == i && 13 == j) {//\键
				_temp=1 + 1 / 4;
				_w=keyWidth * _temp;
			} else if (2 == i && 0 == j) {//Lock键
				_w=keyWidth * 2;
			} else if (2 == i && 12 == j) {//回车键
				_w=keyWidth * 2 + 1;
			} else if (3 == i && 0 == j || 3 == i && 11 == j) {//两个shift键
				_w=keyWidth * 5 / 2 + 1;
			} else {
				_w=keyWidth;
			}
			return _w;
		}
		
		//shift键模式
		private function shiftKeyMode():void {
			lockKeyMode();
			_isShift=! _isShift;
			if (_isShift) {
				for (var i:int=0; i < 13; i++) {
					var tempSgiftCase:*=keyArray[i];
					tempSgiftCase.KeyValue=shiftKeyNameArray[i];
				}
				var temp_key:ButtonKeyMode;
				temp_key=this.getChildByName("KeyName_1_11")  as  ButtonKeyMode;//[键
				temp_key.KeyValue=shiftKeyNameArray[13];//[键-->{
				temp_key=this.getChildByName("KeyName_1_12")  as  ButtonKeyMode;//]键
				temp_key.KeyValue=shiftKeyNameArray[14];//]键-->}
				temp_key=this.getChildByName("KeyName_1_13")  as  ButtonKeyMode;//\键
				temp_key.KeyValue=shiftKeyNameArray[15];//\键-->|

				temp_key=this.getChildByName("KeyName_2_10")  as  ButtonKeyMode;//;键
				temp_key.KeyValue=shiftKeyNameArray[16];//\键-->:
				temp_key=this.getChildByName("KeyName_2_11")  as  ButtonKeyMode;//'键
				temp_key.KeyValue=shiftKeyNameArray[17];//\键-->"

				temp_key=this.getChildByName("KeyName_3_8")  as  ButtonKeyMode;//,键
				temp_key.KeyValue=shiftKeyNameArray[18];//\键--><
				temp_key=this.getChildByName("KeyName_3_9")  as  ButtonKeyMode;//.键
				temp_key.KeyValue=shiftKeyNameArray[19];//\键-->>
				temp_key=this.getChildByName("KeyName_3_10")  as  ButtonKeyMode;///键
				temp_key.KeyValue=shiftKeyNameArray[20];//\键-->?
			} else {
				for (var j:int=0; j < 13; j++) {
					var tempUnSgiftCase:*=keyArray[j];
					tempUnSgiftCase.KeyValue=keyNameArray[0][j];
				}
				var temp_key2:ButtonKeyMode;
				temp_key2=this.getChildByName("KeyName_1_11")  as  ButtonKeyMode;
				temp_key2.KeyValue=keyNameArray[1][11];
				temp_key2=this.getChildByName("KeyName_1_12")  as  ButtonKeyMode;
				temp_key2.KeyValue=keyNameArray[1][12];
				temp_key2=this.getChildByName("KeyName_1_13")  as  ButtonKeyMode;
				temp_key2.KeyValue=keyNameArray[1][13];

				temp_key2=this.getChildByName("KeyName_2_10")  as  ButtonKeyMode;
				temp_key2.KeyValue=keyNameArray[2][10];
				temp_key2=this.getChildByName("KeyName_2_11")  as  ButtonKeyMode;
				temp_key2.KeyValue=keyNameArray[2][11];

				temp_key2=this.getChildByName("KeyName_3_8")  as  ButtonKeyMode;//,键
				temp_key2.KeyValue=keyNameArray[3][8];
				temp_key2=this.getChildByName("KeyName_3_9")  as  ButtonKeyMode;//.键
				temp_key2.KeyValue=keyNameArray[3][9];
				temp_key2=this.getChildByName("KeyName_3_10")  as  ButtonKeyMode;///键
				temp_key2.KeyValue=keyNameArray[3][10];
			}
		}
		
		//lock键模式
		private function lockKeyMode():void {
			//trace("lockKeyMode() call");
			_isLock=! _isLock;
			if (_isLock) {
				for (var i:int=0; i < keyArray.length; i++) {
					var tempUpperCase:*=keyArray[i];
					if (tempUpperCase.name != "null" && tempUpperCase.LetterKey) {
						tempUpperCase.KeyValue=tempUpperCase.KeyValue.toUpperCase();
					}
				}
			} else {
				for (var j:int=0; j < keyArray.length; j++) {
					var tempLowerCase:*=keyArray[j];
					if (tempLowerCase.name != "null" && tempLowerCase.LetterKey) {
						tempLowerCase.KeyValue=tempLowerCase.KeyValue.toLowerCase();
					}
				}
			}
		}
		//关闭字母键属性
		private function closeLetterKey(_key:ButtonKeyMode,i:Number,j:Number):void {
			if (_key.name != "null") {
				if (0 == i) {//第一行数字键
					_key.LetterKey=false;
				} else if (0 == i && 13 == j) {//回格键没有
					_key.LetterKey=false;
				} else if (1 == i && 0 == j) {//Tab键
					_key.LetterKey=false;
				} else if (1 == i && 11 == j || 1 == i && 12 == j || 1 == i && 13 == j) {//[,],\键
					_key.LetterKey=false;
				} else if (2 == i && 0 == j) {//Lock键
					_key.LetterKey=false;
				} else if (2 == i && 12 == j) {//回车键
					_key.LetterKey=false;
				} else if (2 == i && 10 == j || 2 == i && 11 == j) {//分号和单引号
					_key.LetterKey=false;
				} else if (3 == i && 0 == j || 3 == i && 8 == j || 3 == i && 9 == j || 3 == i && 10 == j) {//逗号，句号，斜杠
					_key.LetterKey=false;
				} else if (3 == i && 0 == j || 3 == i && 11 == j) {//两个shift键
					_key.LetterKey=false;
				}
			}
		}
		//关闭shift键属性
		private function closeShiftKey(_key:ButtonKeyMode,i:Number,j:Number):void {
			if (_key.name != "null") {
				if (0 == i && 13 == j) {//回格键没有
					_key.ShiftKey=false;
				} else if (1 == i && 0 == j) {//Tab键
					_key.ShiftKey=false;
				} else if (1 == i && 13 == j) {//\键
					_key.ShiftKey=false;
				} else if (2 == i && 0 == j) {//Lock键
					_key.ShiftKey=false;
				} else if (2 == i && 12 == j) {//回车键
					_key.ShiftKey=false;
				} else if (3 == i && 0 == j || 3 == i && 11 == j) {//两个shift键
					_key.ShiftKey=false;
				}
			}
		}

	}
}