/**
 * 
 * File:		Firework.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-11-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Firework class contains code to explode into more fireworks.
 *
 * It extends Particle and can move.
 *  
 **/
package fireworks
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Firework extends Particle
	{
		/**Class Member Variables**/
		//Fireworks
		protected var simulator                 :  Simulator;
		protected var fuse                      :  Number;//length of time for INITIAL firework to explode and remove from GUI/Logic     
		protected var numberOfPayloadFireworks  :  int;//number of particles that explode from the initial firework
		protected var newPayloadVelocity        :  GeometricVector;//direction and speed of payload fireworks
		protected var newPayloadFuse            :  Number;//length of time for payload firework to be removed from GUI
		protected var fireworkColor     		:  uint;// Color for ball
		protected var hasTrail                  :  Boolean; //Whether or not the FW has a trail
		protected var putTrailCounter           :  int = 0; //counter for placing trails
		
		
		/**CONSTRUCTOR**/
		public function Firework(simulatorParameter: Simulator,
								 fuseParameter: Number,
								 numberOfPayloadFireworksParameter: int,
								 fireworkColorParameter:uint,
								 locationParameter:Point, 
								 velocityParameter:GeometricVector, 
								 massParameter:Number,
								 hasTrailParameter:Boolean)
		{
			/**Pass member variables to particle for math calculations**/
			super(locationParameter, velocityParameter, massParameter);
			
			/**Assign Member Variables to Parameters**/
			this.simulator                = simulatorParameter;
			this.fuse                     = fuseParameter;
			this.numberOfPayloadFireworks = numberOfPayloadFireworksParameter;
			this.fireworkColor			  = fireworkColorParameter;
			this.hasTrail                 = hasTrailParameter;
			
			/**Add to Simulator GUI**/
			//Draw
			this.create_display_list();
			
			//Update location based on math in particle class
			this.update_gui();
			
			//Add to stage
			simulator.addChild(this);
			
			/**Add to Simulator Logic**/
			simulator.add_ball_to_simulation( this );
		}
		
		/**OVERRIDE FUNCTION WHICH MOVES THEN CHECKS THE FUSE AND EXPLODES IF NECESSARY**/
		public override function move(duration:Number):void
		{
			//this.rotation += Math.random() * 10;
			
			/**Movement**/
			//Call particle move function for calculations
			super.move(duration);
			
			putTrailCounter++;
			/** ADD TRAIL **/
			if(hasTrail == true && putTrailCounter > 5) //if it is not already a Trail and counter 
			{
				var trail: Trail;
				
				//create a trail behind the firework
				trail = new Trail(simulator, 7, 0, 0x000000, new Point(this.location.x, this.location.y), new GeometricVector(0,0), 1, false);
				
				//put counter back to 0
				putTrailCounter = 0;
				
				/**Add trail fireworks to simulation LOGIC**/
				simulator.add_ball_to_simulation(trail);	
			}
			
			
			//Update firework location based on particle calculations
			this.update_gui();
			
			//Bounce if necessary
			this.check_for_ground();
			
			/**Exploding**/
			//Reduce the time to detonation by the duration of the move
			this.fuse -= duration;
			
			//When fuse reaches 0, explode
			if (this.fuse <= 0)
			{
				this.burnUp();//remove from GUI and Logic
				//trace(this.name); //--------------------------------------------bug checking
				this.explode();//add payload fireworks to GUI and Logic
			}
		}
		
		/**FUNCTION TO ADD MORE PAYLOAD FIREWORKS AFTER PARENT FIREWORK EXPLODES**/
		protected function explode():void
		{
			//Create new fireworks for the # of payloads
			var currentPayloadFirework: Firework;
			
			for (var i: int = 0; i < numberOfPayloadFireworks; i++)
			{
				/**Payload Variables**/
				//Speed and direction is a randomized positive and negative number within a given range (forms circle/cube)
				this.newPayloadVelocity = new GeometricVector( Math.floor(Math.random() * (50- (-50 + 1) ) ) + -50, Math.floor(Math.random() * (50- (-50 + 1) ) ) + -50);
				
				//Randomize time to removal from Logic and GUI within a given range
				this.newPayloadFuse = Math.random()*10 + 1;
				
				//Create a new payload firework
				currentPayloadFirework = new Firework(simulator, newPayloadFuse, 0, 0x0000FF, new Point(this.location.x, this.location.y), newPayloadVelocity.clone(), 1, true);
							
				/**Add payload fireworks to simulation LOGIC**/
				simulator.add_ball_to_simulation(currentPayloadFirework);				
			}
			
			
		
		}		
		
		/**FUNCTION TO REMOVE THE CURRENT FIREWORK FROM LOGIC AND GUI**/
		protected function burnUp():void
		{
			//Remove from LOGIC
			simulator.remove_ball_from_simulation(this);
			
			//Dana's band-aid fix to remove from GUI (works)
			if(simulator.getChildByName(this.name) != null)
			{
				//Remove from GUI
				simulator.removeChild(this);
			}
		}
		
		/**FUNCTION TO DRAW FIREWORKS**/
		protected function create_display_list():void
		{
						
			/**Set Up**/
			this.graphics.clear();
			this.graphics.lineStyle(0.5, 0xFFFFFF * Math.random(), 1);
			
			//Randomly draw either a circle of random size...
			if(Math.random() > .5)
			{
				this.graphics.drawCircle(0,0,Math.random()*3 + 2);
			}
			//...or a quadrilateral of random size
			else
			{
				var tempWidth:  Number = Math.random()*5 + 2;
				var tempHeight: Number = Math.random()*5 + 2;
				this.graphics.drawRect(-tempWidth/2, -tempHeight/2, tempWidth, tempHeight);
			}
			
		}
		
		/**FUNCTION TO CHECK IF THE FIREWORK IS ON THE GROUND**/
		protected function check_for_ground() : void
		{			
			//SET "GROUND" IN CONDITION
			if (this.location.y < -300)
			{
				//BOUNCE
				//Reverse the vertical velocity to positive (bounce) and have HALF the velocity (friction)
				this.velocity.y = Math.abs(this.velocity.y) * .5;
				
				//Decrease the horizontal velocity by one third (friction)
				this.velocity.x = this.velocity.x * .66;							
			}
		}
		
		/**FUNCTION TO UPDATE FIREWORK LOCATION BY MATH DONE IN THE PARTICLE CLASS**/
		protected function update_gui() : void
		{
			/**NOTE: For some reason our stage or simulator Sprite is mirrored, so we had to mirror the locations of the particles**/
			//set x position to particle calculations for the next x position
			this.x = -this.location.x;
			//set y position to particle calculations for the next y position
			this.y = -this.location.y;
		}
		
	}//end class
}//end package