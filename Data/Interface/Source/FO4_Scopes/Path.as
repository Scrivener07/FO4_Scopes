package
{
	public class Path
	{
		public static function ConvertFileExtension(filepath:String, toExtension:String):String
		{
			return filepath.replace(new RegExp("\\.[^/.]+$", ""), "."+toExtension);
		}
	}
}
