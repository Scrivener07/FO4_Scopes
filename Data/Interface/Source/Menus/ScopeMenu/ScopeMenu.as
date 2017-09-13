package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.IMenu;

	public class ScopeMenu extends IMenu implements IScopeMenu
	{
		public var OverlayLoader_mc:OverlayLoader;

		public var ButtonHintInstance:BSButtonHintBar;
		private var HoldBreathButton:BSButtonHintData;
		private var HoldBreathButtonForVita:BSButtonHintData;


		public function ScopeMenu()
		{
			trace("[ScopeMenu.as]: "+Debug.TraceMovie(this));
			HoldBreathButton = new BSButtonHintData("$Hold Breath", "Alt", "PSN_L3", "Xenon_L3", 1, null);
			HoldBreathButtonForVita = new BSButtonHintData("$Hold Breath", "Alt", "_DPad_Down", "Xenon_L3", 1, null);
			super();

			addFrameScript(0, frame1);
			HoldBreathButtonForVita.ButtonVisible = false;

			var hints:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
			hints.push(HoldBreathButton);
			hints.push(HoldBreathButtonForVita);
			ButtonHintInstance.SetButtonHintData(hints);
		}


		public function SetIsVita(isVita:Boolean) : *
		{
			trace("[ScopeMenu] SetIsVita(isVita="+isVita+")");
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
			trace("[ScopeMenu] SetOverlay(identifier="+identifier+")");
			gotoAndStop(identifier + 1);
		}


		public function SetCustom(filePath:String) : *
		{
			gotoAndStop(18);
			OverlayLoader_mc.Load(filePath);

			Debug.TraceMovie(this);
			trace("[ScopeMenu] SetCustom(filePath="+filePath+")");
		}


		function frame1() : *
		{
			stop();
			trace("[ScopeMenu] frame1()::stop()");
		}


	}
}
