package
{
	public interface IScopeMenu
	{
		function SetIsVita(isVita:Boolean) : *; // native
		function SetOverlay(identifier:uint) : *; // native
		function SetCustom(filePath:String) : *;
		function GetCustom() : String;
		function PathConvert(filepath:String, toExtension:String) : String;
	}
}
