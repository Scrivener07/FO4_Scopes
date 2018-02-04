package
{
	import flash.display.MovieClip;

	public class Scope extends MovieClip
	{

		public function Scope()
		{
			super();
			trace("[Custom Scope]: "+Utility.WalkMovie(this));
		}


		public function Steady() : *
		{
			addFrameScript(0, frame1);
			trace("[Custom Scope] Steady()");
		}


		public function Unsteady() : *
		{
			addFrameScript(0, null);
			play();
			trace("[Custom Scope] Unsteady()");
		}


		function frame1() : *
		{
			stop();
		}


	}
}
