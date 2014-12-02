package  
{
	import BaseAssets.BaseMain;
	import cepa.utils.Angle;
	import cepa.utils.Cronometer;
	import com.adobe.serialization.json.JSON;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Cubic;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import pipwerks.SCORM;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Main extends BaseMain
	{
		private var cronometer:Cronometer;
		private var timerPaused:Boolean;
		
		private var answerTuto:CaixaTexto;
		
		private var debugMode:Boolean = false;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initVariables();
			initCronometro();
			addListeners();
			
			/*if (ExternalInterface.available) {
				initLMSConnection();
				
				if (mementoSerialized != null) {
					if(mementoSerialized != "" && mementoSerialized != "null") recoverStatus();
				}
			}*/
		}
		
		private function initVariables():void
		{
			cronometer = new Cronometer();
			timerPaused = true;
						
			cronometro.time.mouseEnabled = false;
		}
		
		private function initCronometro():void
		{
			cronometro.reset.buttonMode = true;
			cronometro.start.buttonMode = true;
			
			cronometro.start.addEventListener(MouseEvent.MOUSE_DOWN, startCronometro);
			cronometro.reset.addEventListener(MouseEvent.CLICK, resetaCronometro);
		}
		
		private function startCronometro(e:MouseEvent):void 
		{
			if (timerPaused) 
			{
				timerPaused = false;
				cronometer.reset();
				cronometer.start();
				addEventListener(Event.ENTER_FRAME, refreshCron);
			} 
			else 
			{
				timerPaused = true;
				cronometer.pause();
				removeEventListener(Event.ENTER_FRAME, refreshCron);
				feedbackScreen.okCancelMode = false;
				if (Math.abs(cronometer.read()/1000 - 15) <= 0.5) feedbackScreen.setText("Parabéns, você acertou!");
				else feedbackScreen.setText("Tente novamente...");
			}
		}
		
		private function refreshCron(e:Event):void 
		{
			cronometro.time.text = (cronometer.read() / 1000).toFixed(1);
		}
		
		private function resetaCronometro(e:MouseEvent):void 
		{
			
			removeEventListener(Event.ENTER_FRAME, refreshCron);
			
			cronometer.stop();
			cronometer.reset();
			
			cronometro.time.text = "0";
			timerPaused = true;
		}
		
		private function addListeners():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
		}
		
		private function keyDownListener(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE) {
				startCronometro(null);
			}
		}
		
		override public function reset(e:MouseEvent = null):void
		{
			resetaCronometro(null);
		}		

	}

}