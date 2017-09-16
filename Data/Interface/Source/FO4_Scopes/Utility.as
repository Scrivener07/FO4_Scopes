package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class Utility
	{

		public static function WalkMovie(movieClip:MovieClip) : String
		{
			return WalkMovieFrom(movieClip, movieClip);
		}


		public static function WalkMovieFrom(from:DisplayObject, to:MovieClip) : String
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
