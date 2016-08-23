/**
 * 
 * File:		Simulator.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-11-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Simulator class contains code to animate particles.
 *
 * It is a Sprite that is centered on (0,0).
 *  
 **/
package fireworks
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class Simulator extends Sprite
	{
		/**
		 * Here we have two "variables" representing the "state" of the simluation.
		 * 
		 * 1) Describe what the variable "objects" is, (what is its type, its purpose, etc)
		 * 
		 * 		It is an array which holds all of the objects that will be put inside
		 * 		the simulator.  That way all of the objects can be manipulated (updated)
		 * 		by working through the array.
		 * 
		 * 2) Describe what the constant "gravity" is, (why is it const, can we have
		 *    a constant object? what is its type, its purpose, etc).
		 * 
		 * 		Gravity is a GeometricVector that is always dragging all objects
		 * 		downward, so it has to have a negative y-component.  Changing the
		 * 		y component will change how "strong" the gravity is.
		 */
		
		/**Class Member Variables**/
		public var   objects : Array;//array to loop through for animation (contains particles)
		public const gravity : GeometricVector = new GeometricVector(0, -3);//a velocity that is always pulling down or subtracting from all other velocities
		public var player: Player;//user where fireworks are shot from
		
		/**CONSTRUCTOR**/
		public function Simulator(owner: Sprite)
		{
			/**Simulator Sprite**/
			//Center it
			this.x = owner.stage.stageWidth/2;
			this.y = owner.stage.stageHeight/2;
			
			//Add to stage
			owner.addChild(this);
			
			//TEST CODE
			//trace(owner.stage.stageWidth/2);
			
			/**Simulator Logic**/
			//Create array of objects
			this.objects = new Array();

			//Start simulation by animating every frame
			this.start_simulation();
			
			/**Player**/
			player = new Player(this);//create new player on simulator
			
			/**Added Event Listener**/
			this.stage.addEventListener( MouseEvent.CLICK, launchBall );
			
			//TEST CODE
			//trace("simulator constructor running");
		}
		
		/**HANDLER FUNCTION TO CREATE A FIREWORK WHEN THE STAGE IS CLICKED**/
		protected function launchBall(event:MouseEvent):void
		{
			/**Create Firework**/
			var firework:Firework;
			
			firework = new Firework(	this,																		//Owner is the simulator (this)
										Math.random()*10+4, 														//fuse length is randomized
										50, 																		//Payload firework number
										0xff0000, 																	//Default color
										new Point(-event.localX + this.stage.stageWidth/2,-275),					//Location firework is created 
										new GeometricVector(   0 /*((this.stage.stageWidth/2 - event.localX)/5)*/ ,	//Velocity of Firework
															getVelocity(event)   ),
										1,
										true);																			//Mass
			
			/**TEST CODE**/
			//trace(event.stageX);
			//trace(event.stageY);
			//trace("Local (x,y): " + event.localX + "," + event.localY);
			//trace("Calc. (x,y): " + (event.localX - this.stage.stageWidth/2) + "," + (event.localY - this.stage.stageHeight/2)  );
			
		}
		
		/**
		 * Start the simulation: Begin handing events
		 *
		 * 1)  What event and why 
		 * 		Every frame we enter so the particle motions are smooth
		 * 
		 * 2)  Where is the event attached?
		 * 		To the simulator
		 */
		public function start_simulation(  ) : void
		{
			this.addEventListener( Event.ENTER_FRAME, animate );
		}
		
		/**
		 * End the simulation:
		 *
		 * 1) How do we remove an event, what is the syntax?
		 * 		objectWithEvent.removeEventListener( Event.TYPE, callBackFunction);
		 */
		public function stop_simulation(  ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME, animate );
		}
		
		/**
		 * Add a ball to the simulator.
		 *
		 * 1) how do we add an object to the end of an array?
		 * 		use array.push(data);
		 * 
		 * 2) what is the size of the array after adding?
		 * 		one greater than it was before
		 * 
		 * 3) how would we make this function more general ( handle more than balls? )
		 * 		use object:Object in the parameters
		 */
		public function add_ball_to_simulation( particle:Particle ) : void
		{
			this.objects.push( particle );//add particles to simulator LOGIC
		}
		
		/**
		 * Remove a ball from the simulator
		 */
		public function remove_ball_from_simulation( particle:Particle ) : void
		{
			var index_in_array_of_ball : int = this.objects.indexOf( particle );//find particle's index in array
			
			if ( index_in_array_of_ball != -1 )//if it IS in the array
			{
				this.objects.splice(index_in_array_of_ball, 1);//remove it from the array, simulator LOGIC
			}
		}
		
		/**
		 *  Here is the core of our Physics Engine
		 * 
		 *  1) How is it similar to pong?
		 * 		Moves every frame
		 * 
		 *  2) How is it different?
		 * 		Has forces
		 */
		public function animate( e : Event ) : void
		{		
			/**Particle Movement**/
			for each ( var particle:Particle in this.objects )  // Note: In a production version, we would use a "Particle" Interface instead of the Ball Type!
			{
				/**Movement & Force**/
				particle.add_force( gravity );//apply a negative velocity to all velocities to simulate gravity
				particle.move( 0.1 );// tell ball to simulate 1/10 of a second of motion every frame to simulate movement
				particle.clear_forces();//clear forces every frame to determine new calculations
				
				/**Fade Out**/
				if (particle.alpha <= 1.0)
				{
					particle.alpha -= 0.01;//reduce alpha every frame
				}
			}
			
			/**Player Movement**/
			player.move();
		}
		
		/**function to make a velocity with checks for near 0**/
		private function getVelocity(event:MouseEvent):Number
		{
			
			//test
			//trace("localY is: " + event.localY);
			
			//if the click is high enough, just return
			if(((this.stage.stageHeight/2 - event.localY)/5) > 20)
			{
				//trace(   ((this.stage.stageHeight/2 - event.localY)/5)   );
				return ((this.stage.stageHeight/2 - event.localY)/5);
			}
			//if click is near zero, return a default velocity slightly randomized
			else if(((this.stage.stageHeight/2 - event.localY)/5) <= 20)
			{
				return (   Math.random()*(25-15) + 15   );
			}
			//if click is negative, return the same velocity but positive
			
			
			
			return -1.0;
			
		}
	}//end class
}//end package