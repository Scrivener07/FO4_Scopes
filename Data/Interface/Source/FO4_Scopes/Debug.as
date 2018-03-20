package
{
	public class Debug
	{
		public static function Log(className:String, classMember:String, textLog:String):void
		{
			trace("[Scopes Framework]["+className+"."+classMember+"]: "+textLog);
		}
	}
}
