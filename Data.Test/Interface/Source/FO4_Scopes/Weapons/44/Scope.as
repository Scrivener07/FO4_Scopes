package
{
	import flash.display.MovieClip;

	public class Scope extends MovieClip
	{
		public var EndLoop:Boolean = false;


		public function Steady() : *
		{
			EndLoop = false;
			play();
			trace("[Scopes Framework][Pistol 44] Steady Invoked");
		}


		public function Unsteady() : *
		{
			EndLoop = true;
			trace("[Scopes Framework][Pistol 44] Unsteady Invoked");
		}

	}
}
