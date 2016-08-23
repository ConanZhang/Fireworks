/**
 * 
 * File:		Fireworks_Test.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-11-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Fireworks_Test class contains code to create the simulator, change the stage color, size, and framerate.
 *
 * It is a Sprite, but also the stage.
 *  
 **/
package
{
	import fireworks.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**CHANGE BACKGROUND COLOR, STAGE SIZE, AND FRAME RATE**/
	[SWF(backgroundColor="#101010", width="800", height="800", frameRate="55")]
	
	public class Fireworks_Test extends Sprite
	{
		/**Class Member Variables**/
		private var simulator: Simulator;
		
		/**CONSTRUCTOR**/
		public function Fireworks_Test()
		{
			//Create new simulator on this stage
			simulator = new Simulator(this);			
		}
		
	}//end class
}//end package