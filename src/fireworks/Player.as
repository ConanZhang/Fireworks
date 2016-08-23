/**
 * 
 * File:		Player.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-12-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Player class of type Sprite.  Should move and shoot a Ball.
 * 
 **/
package fireworks
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	
	public class Player extends Sprite
	{		
		/**Class Member Variables**/
		//Movement
		protected var playerSpeed:Number = 25;//pixels able to move left or right by every frame
		
		protected var isMovingLeft: Boolean;
		protected var isMovingRight: Boolean;
		
		//Sprite drawing from Flash Pro
		private var drawing: PlayerDrawing;
		
		//Sound
		//private var shootChannel: SoundChannel;//channel for shoot sound
		//private var shootSound: ShootBeep = new ShootBeep();//asset from circleDefenseFLA
		
		//Owner
		private var owner: Sprite;
		
		/**CONSTRUCTOR**/
		public function Player(ownerP: Sprite)
		{
			/**Assign Member Variables to Parameters**/
			owner = ownerP;
			
			//Create new player drawing
			drawing = new PlayerDrawing();
			
			//Size
			drawing.scaleX = 0.25;
			drawing.scaleY = 0.25;
			
			//Location
			drawing.x = 0;
			drawing.y = 275;
			
			//Add drawing to PLAYER CLASS, PLEASE NEVER FORGET TO DO THIS!!!
			this.addChild(drawing);
			
			//Add player to OWNER (simulator)
			owner.addChild(this);
			
			/**Add Event Listeners**/
			/*
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);//player constantly moves in direction pressed, even when no keys are pressed
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyUp);//UNCOMMENT FOR DIFFERENT PLAYER CONTROL (player stops moving on key up)
			*/			
		}

		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function move():void
		{
			/**Mouse move**/
			 
			this.x = stage.mouseX - this.stage.stageWidth/2;
			
			/**Keyboard move**/
			/*
			if(isMovingLeft && drawing.x > -350)
			{
				drawing.x -= playerSpeed;//move left until hits limit set in condition
			}
			else if(isMovingRight && drawing.x < 350)
			{
				drawing.x += playerSpeed;//move right until hits limit set in condition
			}
			*/
		}
		
		/**COLLIDE FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function collide(otherObject: Sprite):Boolean
		{
			return false;//CHANGE ME IF YOU EVER WANT THE PLAYER TO COLLIDE
		}
		
		/**GET NORMAL FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function getNormal():GeometricVector
		{
			return new GeometricVector(-1,0);
		}
		
		
		
		/**FUNCTION TO HANDLE KEY DOWNS**/
		private function handleKeyDown(event:KeyboardEvent):void
		{
			//user presses left arrow or A
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.A)
			{
				isMovingLeft = true;//move left
				isMovingRight = false;//do not move right
				move();
			}
			else if(event.keyCode == Keyboard.RIGHT || event.keyCode == Keyboard.D)//user presses right arrow or D
			{
				isMovingLeft = false;//do not move left
				isMovingRight = true;//move right
				move();
			}
			else if (event.keyCode == Keyboard.SPACE || event.keyCode == Keyboard.SHIFT)//user presses space or shift
			{
				//shoot();//play sound effect
			}
		}
		
		/**FUNCTION TO HANDLE KEY UPS**/
		private function handleKeyUp(event:KeyboardEvent):void
		{
			//when no keys are pressed, DO NOT MOVE
			isMovingLeft = false;
			isMovingRight = false;
		}
		
		/**SHOOT FUNCTION FOR IMPLEMENTED INTERFACE SHOOTER**/
		public function shoot():void
		{
			//shootChannel = shootSound.play();//play shooting sound effect 
		}
		
		/**getX FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getX():int
		{
			return drawing.x;
			
			/**TEST CODE**/
			//trace(drawing.x);
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return drawing.y;
		}
	}//end class
}//end package