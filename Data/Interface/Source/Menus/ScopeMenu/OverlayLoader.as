package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public dynamic class OverlayLoader extends MovieClip
	{
		private var Content:DisplayObject;
		private var ContentLoader:Loader;

		public function get Info() : LoaderInfo { return ContentLoader.contentLoaderInfo; }
		public function get FilePath() : String { return ContentLoader.contentLoaderInfo.url; }
		public function get Instance() : String { return Utility.WalkMovieFrom(Content, this); }


		// Initialize
		//---------------------------------------------

		public function OverlayLoader()
		{
			super();
			this.visible = false;
			Content = null;
			ContentLoader = new Loader();
			ContentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			ContentLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
		}


		// Methods
		//---------------------------------------------

		public function Load(filePath:String) : void
		{
			ContentLoader.close();

			if (Content)
			{
				Unload();
			}
			var urlRequest:URLRequest = new URLRequest(filePath);
			ContentLoader.load(urlRequest);
		}


		public function Unload() : Boolean
		{
			if (Content)
			{
				this.visible = false;
				removeChild(Content);
				Content.loaderInfo.loader.unload();
				return true;
			}
			else
			{
				return false;
			}
		}


		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event) : void
		{
			Content = e.currentTarget.content;
			addChild(Content);
			this.visible = true;
		}


		private function OnLoadError(e:IOErrorEvent) : void
		{
			this.visible = false;
		}


	}
}
