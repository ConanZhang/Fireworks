/**
 * 
 * File:		Trail.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-11-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Trail class is a firework without a payload and has an initial velocity of 0.
 *
 * It extends Firewrok.
 *  
 **/
package fireworks
{
	import flash.geom.Point;
	
	public class Trail extends Firework
	{
		/**CONSTRUCTOR**/
		public function Trail(simulatorParameter: Simulator,
							  fuseParameter: Number,
							  numberOfPayloadFireworksParameter: int,
							  fireworkColorParameter:uint,
							  locationParameter:Point, 
							  velocityParameter:GeometricVector, 
							  massParameter:Number,
							  hasTrailParameter:Boolean)
		{			
			super(simulatorParameter, 
						  fuseParameter, 
						  numberOfPayloadFireworksParameter, 
						  fireworkColorParameter, 
						  locationParameter,
						  velocityParameter, 
						  massParameter,
						  hasTrailParameter);
		}
		
		/**OVERRIDE FUNCTION TO DRAW DIFFERENTLY**/
		protected override function create_display_list():void
		{
			/**Set Up**/
			this.graphics.clear();
			this.graphics.lineStyle(0.5, 0xFFFFFF, 0.3);
			
			//Randomly draw either a circle of random size...
			if(Math.random() > .5)
			{
				this.graphics.drawCircle(0,0,Math.random()*2 + 1);
			}
				//...or a quadrilateral of random size
			else
			{
				var tempWidth:  Number = Math.random()*3 + 1;
				var tempHeight: Number = Math.random()*3 + 1;
				this.graphics.drawRect(-tempWidth/2, -tempHeight/2, tempWidth, tempHeight);
			}
		}
	}
}