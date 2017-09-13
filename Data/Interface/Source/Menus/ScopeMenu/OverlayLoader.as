package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public dynamic class OverlayLoader extends MovieClip
	{
		private var Content:DisplayObject;
		private var loader:Loader;


		// Initialize
		//---------------------------------------------

		public function OverlayLoader()
		{
			super();
			Content = null;
			loader = new Loader();
			trace("[ScopeMenu:OverlayLoader.as]: "+Debug.TraceMovie(this));
		}


		// Overlays
		//---------------------------------------------

		public function Load(filePath:String) : void
		{
			trace("[ScopeMenu:OverlayLoader] Load(filePath="+filePath+")");
			loader.close();

			if (Content)
			{
				Unload(Content);
			}

			var urlRequest:URLRequest = new URLRequest(filePath);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError, false, 0, true);
			loader.load(urlRequest);
		}


		public function Unload(displayObject:DisplayObject) : void
		{
			trace("[ScopeMenu:OverlayLoader] Unload");
			removeChild(displayObject);
			displayObject.loaderInfo.loader.unload();
		}


		// Events
		//---------------------------------------------

		private function OnLoadError(e:IOErrorEvent) : *
		{
			trace("[ScopeMenu:OverlayLoader] OnLoadError: "+e);
		}


		public function OnLoadComplete(e:Event) : void
		{
			Content = e.currentTarget.content;
			addChild(Content);

			Debug.TraceMovieFrom(Content, this);
			trace("[ScopeMenu:OverlayLoader] OnLoadComplete");
		}


	}
}
