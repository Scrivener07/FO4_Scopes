package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import 	flash.display.LoaderInfo;
	import flash.text.TextField;

	public dynamic class OverlayLoader extends MovieClip
	{
		var SWF:DisplayObject;
		var menuLoader:Loader;
		var ClipAlpha:Number = 0.65;
		var ClipScale:Number = 0.5;

		public function set clipAlpha(aValue:Number) : * { this.ClipAlpha = aValue; }
		public function set clipScale(aValue:Number) : * { this.ClipScale = aValue; }
		public function get Info() : LoaderInfo { return menuLoader.contentLoaderInfo; }


		// Initialize
		//---------------------------------------------

		public function OverlayLoader()
		{
			super();
			this.SWF = null;
			this.menuLoader = new Loader();
		}


		// Overlays
		//---------------------------------------------

		public function SWFLoad(assetName:String) : void
		{
			trace("[ScopeMenu] SWFLoad(assetName="+assetName+")");
			this.menuLoader.close();

			if (this.SWF)
			{
				this.SWFUnload(this.SWF);
			}

			var urlRequest:URLRequest = new URLRequest(assetName);
			this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			this.menuLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError, false, 0, true);
			this.menuLoader.load(urlRequest);
		}


		public function SWFUnload(displayObject:DisplayObject) : void
		{
			trace("[ScopeMenu] SWFUnload(displayObject="+displayObject+")");
			removeChild(displayObject);
			displayObject.loaderInfo.loader.unload();
		}


		// Resources
		//---------------------------------------------

		private function OnLoadError(e:IOErrorEvent) : *
		{
			trace("[ScopeMenu] OnLoadError: "+e);
		}


		public function OnLoadComplete(e:Event) : void
		{
			this.SWF = e.currentTarget.content;
			this.SWF.scaleX = this.ClipScale;
			this.SWF.scaleY = this.ClipScale;
			this.SWF.alpha = this.ClipAlpha;
			addChild(this.SWF);

			trace("[ScopeMenu] OnLoadComplete: "+SWF.toString());
		}


	}
}
