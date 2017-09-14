package
{
	public interface IScopeMenu
	{
		function SetIsVita(isVita:Boolean) : *; // native
		function SetOverlay(identifier:uint) : *; // native
		function SetCustom(filePath:String) : *;
		function ConvertPath(filepath:String, toExtension:String) : String
	}
}
