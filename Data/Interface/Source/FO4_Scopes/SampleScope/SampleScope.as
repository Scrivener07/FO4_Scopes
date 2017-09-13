package
{
	import flash.display.MovieClip;

	public class SampleScope extends MovieClip
	{

		public function SampleScope()
		{
			super();
			trace("[SampleScope.as]: "+Debug.TraceMovie(this));
		}


		public function Steady() : *
		{
			addFrameScript(0, frame1);
			trace("[SampleScope] Steady()");
		}


		public function Unsteady() : *
		{
			addFrameScript(0, null);
			play();
			trace("[SampleScope] Unsteady()");
		}


		function frame1() : *
		{
			// You can remove an added frame script by setting the script to null.
			// Ex: mc.addFrameScript(0, null);
			stop();
			trace("[SampleScope] frame1()::stop()");
		}


	}
}
