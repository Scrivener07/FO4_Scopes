package
{
	import Components.AssetLoader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.IMenu;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.IO.Path;
	import F4SE.Extensions;

	public class ScopeMenu extends IMenu implements IScopeMenu, F4SE.ICodeObject
	{
		// F4SE
		protected var f4se:*;

		// Loader
		public var Controller:MovieClip;
		private var Scope:ScopeLoader;
		private var ScopeFrame:int = 0;
		private const Name:String = "ScopeMenu";
		private const MountID:String = "ScopeMenu_ImageMount";

		// Client
		private const ClientLoadedEvent:String = "ScopeMenu_ClientLoadedEvent";

		// Buttons
		public var ButtonHintInstance:BSButtonHintBar;
		private var HoldBreathButton:BSButtonHintData;
		private var HoldBreathButtonForVita:BSButtonHintData;


		// Initialize
		//---------------------------------------------

		public function ScopeMenu()
		{
			System.Diagnostics.Debug.Prefix = "Scope Framework";
			HoldBreathButton = new BSButtonHintData("$Hold Breath", "Alt", "PSN_L3", "Xenon_L3", 1, null);
			HoldBreathButtonForVita = new BSButtonHintData("$Hold Breath", "Alt", "_DPad_Down", "Xenon_L3", 1, null);
			super();
			addFrameScript(0, this.frame1);
			HoldBreathButtonForVita.ButtonVisible = false;
			var hints:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
			hints.push(HoldBreathButton);
			hints.push(HoldBreathButtonForVita);
			ButtonHintInstance.SetButtonHintData(hints);

			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Debug.WriteLine("[ScopeMenu]", "(ctor)", "Constructed the scope menu.", this.loaderInfo.url);
		}


		private function OnAddedToStage(e:Event):void
		{
			Scope = new ScopeLoader(Name, MountID);
			Scope.addEventListener(AssetLoader.LOAD_COMPLETE, this.OnLoadComplete);
			Scope.addEventListener(AssetLoader.LOAD_ERROR, this.OnLoadError);
			Scope.visible = false;
			Controller.addChild(Scope);
			Debug.WriteLine("[ScopeMenu]", "(OnAddedToStage)");
		}


		public function onF4SEObjCreated(codeObject:*):void
		{
			F4SE.Extensions.API = codeObject;
			Debug.WriteLine("[ScopeMenu]", "(onF4SEObjCreated)", codeObject);
			Utility.TraceObject(codeObject);
		}


		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event):void
		{
			gotoAndStop("Custom");
			Scope.visible = true;
			var client:String = GetClient();
			Extensions.SendExternalEvent(ClientLoadedEvent, client);
			Debug.WriteLine("[ScopeMenu]", "(OnLoadComplete)", "Scope found at '"+Scope.FilePath+"' with client instance of '"+client+"'.");
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Scope.visible = false;
			gotoAndStop(ScopeFrame);
			Debug.WriteLine("[ScopeMenu]", "(OnLoadError)", "No scope found at '"+Scope.FilePath+"'. Moving to frame "+ScopeFrame);
		}


		// Methods
		//---------------------------------------------

		//** Loads the given filepath as a scope overlay. */
		public function Load(filePath:String):*
		{
			Debug.WriteLine("[ScopeMenu]", "(Load)", "Setting the scope file path to '"+filePath+"'.");
			Scope.Load(filePath);
		}


		/**
		 * Gets the instance variable to the loaded client scope overlay.
		 */
		public function GetClient():String
		{
			return Scope.GetInstance();
		}


		/**
		 * Called by the game engine to set the scope overlay.
		 * This value is derived from the ZoomData `Overlay` value, as seen in the Creation Kit.
		 * @param identifier - The scope overlay identifier to use.
		 */
		public function SetOverlay(identifier:uint):*
		{
			Debug.WriteLine("[ScopeMenu]", "(SetOverlay)", "The overlay identifier is being set to "+identifier);
			ScopeFrame = identifier + 1;
			gotoAndStop(ScopeFrame);
		}

		/**
		 * Called by the game engine to configure the button menu for compatibility with the Vita platform.
		 * @param isVita - Use true to apply the Vita platform, use false to apply the PC platform.
		 */
		public function SetIsVita(isVita:Boolean):*
		{
			Debug.WriteLine("[ScopeMenu]", "(SetIsVita)", isVita);
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


		// Frames
		//---------------------------------------------

		function frame1() : *
		{
			stop();
		}


	}
}
