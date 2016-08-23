/**
 *  Author:   H. James de S.t Germain
 *  Date:     Fal 2007
 *  Course:   CS 1410 - EAE
 * 
 *  Description:
 * 
 *      This class represents a Geometric (mathematical) Vector.
 *
 *      A vector is a direction and magnitude in (2d) space.  A vector
 *      is represented by a length in the X direction and a length in the Y
 *      direction.  Combined these form a length and direction in the 2d plane.
 *
 *      A vector has many nice mathematical properties, including the
 *      abilitiy to scale them, add them, rotate them, etc.
 *
 */

package  fireworks
{
	import flash.geom.Point;
	
	public class GeometricVector
	{
		
		/**
		 * The X,Y components represent the length of the vector
		 * in both directions.  Combined they form the actual vector
		 *
		 * All vectors are visualized as being arrows from the origin
		 * (0,0) to the given x,y coordinates.
		 *
		 * To make access to the x and y easy, the PUBLIC tag is used.
		 * This avoids the necessity of get and set methods.
		 */
		
		public var x : Number;
		public var y : Number;
		
		/**
		 * The default constructor is to form a vector of the given x,y
		 *
		 * Parameters x,y
		 * 
		 */
		public function 
			GeometricVector( x : Number  = 0, y : Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 *
		 * Multiply the current vector's X and Y by the given value.
		 * 
		 * Parameters: value (Number) : how much to multiply both X and
		 *                              Y (independtly by)
		 *
		 * Return Type: void (no value is computed)
		 */
		public function
			scale( value : Number ) : void
		{
			this.x = this.x * value;
			this.y = this.y * value;
		}
		
		/**
		 * Compute the length (i.e., the magnitude) of the vector.
		 * Use the Pythagorean theorem.
		 *
		 * Parameters: None
		 * Retrun Type: Number (the length of the vector)
		 */
		public function
			magnitude( ) : Number
		{
			return Math.sqrt(this.x * this.x + this.y * this.y);
		}
		
		/**
		 * Normalize the vector (Given any vector, keep the same
		 * direction but set the length to one)
		 *
		 * Parameters: None
		 * Return Type: None 
		 *
		 * This code modifies the current vector "in place"
		 * 
		 * WARNING: you should never normalize a zero magnitude vector
		 */
		public function
			normalize( ) : void
		{
			
			// WARNING: Very important to store the current magnitude before
			//          manipulating x and y
			var mag : Number = this.magnitude();
			
			this.x = this.x / mag;
			this.y = this.y / mag;
		}
		
		/**
		 * STATIC function
		 *
		 * Convert a number in degrees to the equivalent number in Radians
		 *
		 * Parameters : Degrees (Number)
		 * Return Type: Number
		 *
		 * Use the formula:   radians = (degrees / 180) * Pi
		 */
		public static function
			degrees_to_radians( degrees : Number ) : Number
		{
			return degrees / 180.0 * Math.PI;
		}
		
		/**
		 * Rotate the vector clockwise around the origin by the given angle in degrees
		 *
		 * Parameters: degrees (Number)
		 * Return Type: void  : Rotate the vector "in place"
		 */
		public function
			rotate( degrees : int ) : void
		{
			var radians:Number = degrees_to_radians( -degrees );
			
			// WARNING: Must compute new_x and new_y before modifying this.x or this.y.
			var new_x:Number = Math.cos( radians )* this.x - Math.sin( radians ) * this.y;
			var new_y:Number = Math.sin( radians )* this.x + Math.cos( radians ) * this.y;
			
			this.x = new_x;
			this.y = new_y;
		}
		
		/**
		 *  Add one vector to another.
		 *
		 *  This is accomplished by adding the x component and the y component
		 *  each separately.
		 * 
		 *  Parameters:   vec (Geometric_Vector): The vector to add
		 *  Return Type:  None : Modify the current vector "in place"
		 *
		 */
		public function
			add_to_me( vec : GeometricVector  ) : void
		{       
			this.x += vec.x;
			this.y += vec.y;
		}
		
		/**
		 *  Add twovectors to produce a new vector
		 *
		 *  This is accomplished by adding the x component and the y component
		 *  each separately.
		 * 
		 *  Parameters:   vec1, vec2 (Geometric_Vector): The vectors to add
		 *  Return Type:  Vector
		 *
		 */ 
		public static function add( vec1 : GeometricVector, vec2 : GeometricVector  ) : GeometricVector
		{       
			return new GeometricVector( vec1.x + vec2.x, vec1.y + vec2.y );
		}
		
		/**
		 *  Add a vector to a point to get a new point
		 *
		 *  This is accomplished by adding the x component and the y component
		 *  each separately.
		 * 
		 *  Parameters:   pt1 (Point), vec2 (Geometric_Vector):
		 *  Return Type:  Point
		 *
		 */
		public static function add_point_vector( point: Point, vec : GeometricVector  ) : Point
		{       
			return new Point( point.x + vec.x, point.y + vec.y );
		}
		
		/**
		 *  to String
		 * 
		 *  Return a concise description of the object.  Useful with the TRACE function.
		 *
		 *  Parameters:  None (use the member variables)
		 *  Return Type: String (a concise message describing this object)
		 */
		public  function 
			toString() : String
		{
			return "Vec(" + this.x + ", " + this.y + ")";
		}
		
		/**
		 *  clone
		 * 
		 *  Return a copy of this vector
		 *
		 */
		public  function 
			clone() : GeometricVector
		{
			return new GeometricVector(this.x, this.y); 
		}
		
		/**
		 *
		 * 
		 */
		public function dot( other : GeometricVector ) : Number
		{
			return (this.x * other.x) + (this.y * other.y);
		}
		
		/**
		 *  project onto
		 * 
		 *  Return a new vector which is the result of this vector being
		 *  projected onto the other vector
		 * 
		 *  WARNING: you should never project onto a 0 magnitude vector 
		 *
		 */
		public  function 
			project_on_to( other : GeometricVector ) : GeometricVector
		{
			var dot : Number = this.dot( other );
			var sum : Number = (other.x * other.x) + (other.y * other.y);
			
			return new GeometricVector( (dot/sum) * other.x, (dot/sum) * other.y);
		}
		
		
		/**
		 *  mirror arround
		 * 
		 *  Return a new vector which is the result of "mirroring"
		 *  this vector around the given vector
		 *
		 */
		public  function 
			mirror_around( other : GeometricVector ) : GeometricVector
		{
			var projected:GeometricVector = this.project_on_to( other );
			var offset:GeometricVector    = new GeometricVector(projected.x - this.x, projected.y- this.y); 
			
			return new GeometricVector( this.x + (offset.x * 2), this.y + (offset.y * 2));
		}
	}
}

















