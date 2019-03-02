package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.Debug;
	import Shared.AS3.Path;
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
			Debug.WriteLine("ScopeMenu", "Constructor", "Constructed the scope menu.");
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
			Debug.WriteLine("ScopeMenu", "SetIsVita", "The argument isVita equals "+isVita);
		}


		public function SetOverlay(identifier:uint) : *
		{
			OverlayFrame = identifier + 1;
			gotoAndStop(OverlayFrame);
			Debug.WriteLine("ScopeMenu", "SetOverlay", "The overlay identifier is being set to "+identifier);
		}


		public function SetCustom(filePath:String) : *
		{
			OverlayLoader_mc.Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			OverlayLoader_mc.Load(filePath);
			Debug.WriteLine("ScopeMenu", "SetCustom", "Setting the custom overlay file path to '"+filePath+"'.");
		}


		public function GetCustom() : String
		{
			Debug.WriteLine("ScopeMenu", "GetCustom", "Instance equals '"+OverlayLoader_mc.Instance+"'.");
			return OverlayLoader_mc.Instance;
		}


		public function ConvertFileExtension(filepath:String, toExtension:String) : String
		{
			var converted = Path.ConvertFileExtension(filepath, toExtension);
			Debug.WriteLine("ScopeMenu", "ConvertFileExtension", "Converting file path '"+filepath+"' to '"+toExtension+"' extension as '"+converted+"'.");
			return converted;
		}


		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event) : void
		{
			OverlayLoader_mc.Info.removeEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.removeEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			gotoAndStop("Custom");
			Debug.WriteLine("ScopeMenu", "OnLoadComplete", "Override found at '"+OverlayLoader_mc.FilePath+"' with instance of '"+OverlayLoader_mc.Instance+"'.");
		}


		private function OnLoadError(e:IOErrorEvent) : void
		{
			OverlayLoader_mc.Info.removeEventListener(Event.COMPLETE, this.OnLoadComplete);
			OverlayLoader_mc.Info.removeEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			gotoAndStop(OverlayFrame);
			Debug.WriteLine("ScopeMenu", "OnLoadError", "No override found at '"+OverlayLoader_mc.FilePath+"'. Moving to frame "+OverlayFrame);
		}


		// Frames
		//---------------------------------------------

		function frame1() : *
		{
			stop();
		}


	}
}
