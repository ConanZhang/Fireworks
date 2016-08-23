/**
 * 
 * File:		Particle.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-11-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Particle class contains code to do math surrounding the properties of particles such as
 * position, velocity, forces, and movement.
 *
 * It is a Sprite and can move.
 *  
 **/
package fireworks
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Particle extends Sprite
	{
		/**Class Member Variables**/
		protected var location          :       Point;            // Where the ball is
		protected var velocity          :       GeometricVector;  // Where it is going (speed and direction combined) 
		
		protected var inverse_mass      :       Number;           // Size of Ball (inversed due to math formula velocity = force/mass)
		protected var force_acting_on   :       GeometricVector;  // Forces "pushing/pulling" on the ball (e.g., gravity)
		
		/**CONSTRUCTOR**/
		public function Particle(locationParameter:Point, 
								 velocityParameter:GeometricVector, 
								 massParameter:Number)
		{
			/**Assign Member Variables to Parameters**/
			this.location = locationParameter.clone();   // why clone?
			this.velocity = velocityParameter.clone();	 // so you are not affecting the actual variable, just taking from it to work with in the class
			
			this.force_acting_on = new GeometricVector(0,0);//create initial force that does nothing for now
			this.inverse_mass = 1 / massParameter;//inverse due to formula velocity = force/mass)		
		}
		
		/**FUNCTION TO ADD FORCES (VECTORS) TOGETHER**/
		public function add_force( force : GeometricVector ) : void
		{
			this.force_acting_on.add_to_me( force );
		}
		
		/**FUNCTION TO CLEAR FORCES ACTING ON PARTICLE**/
		public function clear_forces( ) : void
		{
			// which is better?
			// 1: 
			//SLOWEST......
			//this.force_acting_on =  new GeometricVector(0,0);
			
			// 2:
			// FASTEST
			this.force_acting_on.x = 0;//reset x direction to 0
			this.force_acting_on.y = 0;//reset y direction to 0
			
			// 3:
			// 2ND SLOWEST...
			//this.force_acting_on.scale( 0 );
		}
		
		/**FUNCTION TO CALCULATE NEXT POSITION & VELOCITY OF PARTICLE THEN CHANGE VALUES ACCORDINGLY**/
		public function move( duration:Number ) : void
		{
			if (duration <= 0.0) return;//if there is no interval where the particle moves, break out of function and DON'T MOVE
			
			// update the location based on the velocity (note: not using a^2 / 2)
			// POSITION     =   POSITION      +    (VELOCITY     *    dT )
			this.location.x = this.location.x + (this.velocity.x * duration);//increase x position
			this.location.y = this.location.y + (this.velocity.y * duration);//increase y position
			
			// update velocity based on acceleration
			// VELOCITY     =   VELOCITY      +    ( FORCE              /          MASS )   *    dT
			this.velocity.x = this.velocity.x + (this.force_acting_on.x * this.inverse_mass * duration);
			this.velocity.y = this.velocity.y + (this.force_acting_on.y * this.inverse_mass * duration);			
		}		
		
		// TURN THE INVERSE_MASS into MASS
		public function get_mass() : Number
		{
			/**ERROR: DIVIDING BY 0**/
			if (this.inverse_mass == 0)
			  {
			    return Number.POSITIVE_INFINITY;
			  }
			
			//code for converting inverse_mass into mass and returning it
			return 1.0 / this.inverse_mass;
		}
		
	}//end class
}//end package