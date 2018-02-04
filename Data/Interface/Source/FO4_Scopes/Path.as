package
{
	public class Path
	{
		public static function ConvertFileExtension(filepath:String, toExtension:String):String
		{
			return filepath.substr(0, filepath.length - 3) + toExtension;
		}
	}
}
