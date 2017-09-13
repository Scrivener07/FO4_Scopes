package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class Debug
	{


		public static function TraceMovie(movieClip:MovieClip) : String
		{
			return TraceMovieFrom(movieClip, movieClip);
		}


		public static function TraceMovieFrom(from:DisplayObject, to:MovieClip) : String
		{
			var path:String = from.name;
			while (from != to.root)
			{
				from = from.parent;
				path = from.name+"."+path;
			};
			return "stage."+path;
		}


	}
}
