package
{
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
			trace("[ScopeMenu.as]");
			this.HoldBreathButton = new BSButtonHintData("$Hold Breath", "Alt", "PSN_L3", "Xenon_L3", 1, null);
			this.HoldBreathButtonForVita = new BSButtonHintData("$Hold Breath", "Alt", "_DPad_Down", "Xenon_L3", 1, null);
			super();

			addFrameScript(0, this.frame1);
			this.HoldBreathButtonForVita.ButtonVisible = false;

			var hints:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
			hints.push(this.HoldBreathButton);
			hints.push(this.HoldBreathButtonForVita);
			this.ButtonHintInstance.SetButtonHintData(hints);
		}


		public function SetIsVita(isVita:Boolean) : *
		{
			trace("[ScopeMenu] SetIsVita(isVita="+isVita+")");
			if (isVita)
			{
				this.HoldBreathButton.ButtonVisible = false;
				this.HoldBreathButtonForVita.ButtonVisible = true;
			}
			else
			{
				this.HoldBreathButton.ButtonVisible = true;
				this.HoldBreathButtonForVita.ButtonVisible = false;
			}
		}


		public function SetOverlay(overlay:uint) : *
		{
			trace("[ScopeMenu] SetOverlay(overlay="+overlay+")");
			this.gotoAndStop(overlay + 1);
		}


		public function SetCustom(overlay:String) : *
		{
			trace("[ScopeMenu] SetCustom(overlay="+overlay+") OverlayLoader_mc="+OverlayLoader_mc.name);
			this.gotoAndStop(18);
			OverlayLoader_mc.clipScale = 1.0;
			OverlayLoader_mc.clipAlpha = 1;
			OverlayLoader_mc.SWFLoad(overlay);
		}


		function frame1() : *
		{
			stop();
		}


	}
}
