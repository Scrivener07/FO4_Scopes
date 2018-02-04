package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.IMenu;

	public class ScopeMenu extends IMenu implements IScopeMenu
	{
		public var OverlayLoader_mc:OverlayLoader;
		public var ButtonHintInstance:BSButtonHintBar;

		private var HoldBreathButton:BSButtonHintData;
		private var HoldBreathButtonForVita:BSButtonHintData;

		public var OverlayFrame:int = 0;


		// Initialize
		//---------------------------------------------

		public function ScopeMenu()
		{
			HoldBreathButton = new BSButtonHintData("$Hold Breath", "Alt", "PSN_L3", "Xenon_L3", 1, null);
			HoldBreathButtonForVita = new BSButtonHintData("$Hold Breath", "Alt", "_DPad_Down", "Xenon_L3", 1, null);
			super();
			addFrameScript(0, this.frame1);
			HoldBreathButtonForVita.ButtonVisible = false;
			var hints:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
			hints.push(HoldBreathButton);
			hints.push(HoldBreathButtonForVita);
			ButtonHintInstance.SetButtonHintData(hints);
		}


		// Methods
		//---------------------------------------------

		public function SetIsVita(isVita:Boolean) : *
		{
			if (isVita)
			{
				HoldBreathButton.ButtonVisible = false;
				HoldBreathButtonForVita.ButtonVisible = true;
			}
			else
			{
				HoldBreathButton.ButtonVisible = true;
				HoldBreathButtonForVita.ButtonVisible = false;
			}
		}


		public function SetOverlay(identifier:uint) : *
		{
			OverlayFrame = identifier + 1;
			gotoAndStop(OverlayFrame);
			trace("[ScopeMenu] SetOverlay(identifier="+identifier+")");
		}


		public function SetCustom(filePath:String) : *
		{
			OverlayLoader_mc.Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			OverlayLoader_mc.Load(filePath);
			trace("[ScopeMenu] SetCustom(filePath="+filePath+")");
		}


		public function GetCustom() : String
		{
			return OverlayLoader_mc.Instance;
		}


		public function PathConvert(filepath:String, toExtension:String) : String
		{
			trace("[ScopeMenu] PathConvert(filepath="+filepath+", toExtension="+toExtension+")");
			return Path.ConvertFileExtension(filepath, toExtension);
		}


		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event) : void
		{
			OverlayLoader_mc.Info.removeEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.removeEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			gotoAndStop("Custom");
			trace("[ScopeMenu] OnLoadComplete: "+OverlayLoader_mc.FilePath+", Instance: "+OverlayLoader_mc.Instance);
		}


		private function OnLoadError(e:IOErrorEvent) : void
		{
			OverlayLoader_mc.Info.removeEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.removeEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			gotoAndStop(OverlayFrame);
			trace("[ScopeMenu] OnLoadError: No override found at '"+OverlayLoader_mc.FilePath+"'.");
		}


		// Frames
		//---------------------------------------------

		function frame1() : *
		{
			stop();
		}


	}
}
