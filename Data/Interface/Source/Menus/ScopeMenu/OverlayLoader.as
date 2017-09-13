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
				Unload();
			}

			var urlRequest:URLRequest = new URLRequest(filePath);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError, false, 0, true);
			loader.load(urlRequest);
		}


		public function Unload() : Boolean
		{
			if (Content)
			{
				removeChild(Content);
				Content.loaderInfo.loader.unload();
				return true;
			}
			else
			{
				trace("[ScopeMenu:OverlayLoader] Nothing to unload right now.");
				return false;
			}
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
			trace("[ScopeMenu:OverlayLoader] OnLoadComplete:"+Debug.TraceMovieFrom(Content, this));
		}


	}
}
