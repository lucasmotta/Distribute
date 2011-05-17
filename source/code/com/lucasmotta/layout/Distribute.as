package com.lucasmotta.layout
{

	import com.lucasmotta.core.IDistribute;
	import com.lucasmotta.core.IPath;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * @author			Lucas Motta - http://lucasmotta.com
	 * @version			1.0
	 * @since			May 17, 2011
	 * 
	 * A helpful class to distribute an array of display objects along a path
	 */
	public class Distribute implements IDistribute
	{

		// ----------------------------------------------------
		// PRIVATE AND PROTECTED VARIABLES
		// ----------------------------------------------------
		protected var _items : Array;

		protected var _path : IPath;

		protected var _startAt : int;
		
		protected var _offset : Point;


		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 * 
		 * @param items			An array containing all your children
		 * @param path			A path instance that your children will follow
		 * @param offset		Offset position for the children
		 */
		public function Distribute(items : Array, path : IPath, offset : Point = null)
		{
			_items = items;
			_path = path;
			_offset = offset || new Point();

			distribute();
		}

		// ----------------------------------------------------
		// STATIC METHODS
		// ----------------------------------------------------
		/**
		 * Distribute the children on a Rectangle path
		 * 
		 * @param items			An array with all your items
		 * @param width			Width of your rectangle
		 * @param height		Height of your rectangle
		 * @param align			Alignment of your rectangle (default is on the middle/center)
		 * 
		 * @return				Return a Distribute instance
		 */
		public static function rectangle(items : Array, width : int = 200, height : int = 200, align : String = null) : IDistribute
		{
			var path : Path = new Path();
			path.offset = DistributeAlign.getOffset(width, height, align);
			path.add(new Point(-width * .5, -height * .5)).add(new Point(width * .5, -height * .5)).add(new Point(width * .5, height * .5)).add(new Point(-width * .5, height * .5)).add(new Point(-width * .5, -height * .5));

			return new Distribute(items, path);
		}

		/**
		 * Distribute the children on a Polygon path
		 * 
		 * @param items			An array with all your items
		 * @param sides			Sides of your polygon
		 * @param radius		Radius of your polygon
		 * @param align			Alignment of your polygon (default is on the middle/center)
		 * 
		 * @return				Return a Distribute instance
		 */
		public static function polygon(items : Array, sides : int = 5, radius : Number = 100, align : String = null) : IDistribute
		{
			var i : int;
			var piece : Number;
			var radians : Number;
			var ratio : Number = 360 / sides;
			var angle : Number = Math.PI / (sides % 4 ? 2 : 4);

			var path : Path = new Path();
			path.offset = DistributeAlign.getOffset(radius * 2, radius * 2, align);

			for (i = 0; i < sides; i++)
			{
				piece = (ratio * i);
				radians = (Math.PI * 2 / 360) * piece;
				path.add(new Point(Math.round(Math.cos(radians - angle) * radius), Math.round(Math.sin(radians - angle) * radius)));
			}
			path.add(new Point(Math.round(Math.cos(-angle) * radius), Math.round(Math.sin(-angle) * radius)));

			return new Distribute(items, path);
		}

		/**
		 * Distribute the children on a Polygon path
		 * 
		 * @param items			An array with all your items
		 * @param radius		Radius of your circle
		 * @param align			Alignment of your circle (default is on the middle/center)
		 * 
		 * @return				Return a Distribute instance
		 */
		public static function circle(items : Array, radius : Number = 100, align : String = null) : IDistribute
		{
			return Distribute.polygon(items, items.length, radius, align);
		}

		/**
		 * Distribute the children on a Triangle path
		 * 
		 * @param items			An array with all your items
		 * @param radius		Radius of your triangle
		 * @param align			Alignment of your triangle (default is on the middle/center)
		 * 
		 * @return				Return a Distribute instance
		 */
		public static function triangle(items : Array, radius : Number = 100, align : String = null) : IDistribute
		{
			return Distribute.polygon(items, 3, radius, align);
		}

		/**
		 * Distribute the children on a Star path
		 * 
		 * @param items			An array with all your items
		 * @param points		Number of points of your star
		 * @param innerRadius	Inner radius of your star (usually is half of the outerRadius)
		 * @param outerRadius	Outer radius of your star
		 * @param align			Alignment of your triangle (default is on the middle/center)
		 * 
		 * @return				Return a Distribute instance
		 */
		public static function star(items : Array, points : uint, innerRadius : Number = 50, outerRadius : Number = 100, align : String = null) : IDistribute
		{
			var path : Path = new Path();
			path.offset = DistributeAlign.getOffset(Math.max(innerRadius, outerRadius) * 2, Math.max(innerRadius, outerRadius) * 2, align);

			var step : Number,halfStep : Number, rot : Number, px : int, py : int, i : int;
			step = (Math.PI * 2) / points;
			halfStep = step / 2;
			rot = Math.PI / (points % 4 ? 2 : 4);
			px = Math.round(Math.cos(- rot) * outerRadius);
			py = Math.round(Math.sin(- rot) * outerRadius);
			path.add(new Point(px, py));
			for (i = 1; i <= points; i++)
			{
				px = Math.round(Math.cos((step * i) - halfStep - rot) * innerRadius);
				py = Math.round(Math.sin((step * i) - halfStep - rot) * innerRadius);
				path.add(new Point(px, py));
				px = Math.round(Math.cos((step * i) - rot) * outerRadius);
				py = Math.round(Math.sin((step * i) - rot) * outerRadius);
				path.add(new Point(px, py));
			}

			return new Distribute(items, path);
		}

		// ----------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------
		/**
		 * Distribute your children on the path
		 * 
		 * @param startAt		Position of where your first child should start (default is 0)
		 * 
		 * @return				The Distribute class
		 */
		public function distribute(startAt : int = 0) : IDistribute
		{
			var i : int;
			var length : int = _items.length;
			var child : DisplayObject;
			var pos : Point;
			var id : int;

			_startAt = startAt < 0 ? length - startAt : startAt;

			for (i = 0; i < length; i++)
			{
				id = (i + _startAt) % length;
				child = _items[id];
				pos = _path.getPointAt(i / (_path.closedPath ? length : length - 1));
				child.x = pos.x + _offset.x;
				child.y = pos.y + _offset.y;
				child.rotation = 0;
			}

			return this;
		}

		/**
		 * Rotate your children based on the next/closest available position on the path
		 * 
		 * @param angleOffset	Offset rotation (default is 0)
		 * 
		 * @return				The Distribute class
		 */
		public function orientToPath(angleOffset : Number = 0) : IDistribute
		{
			var i : int;
			var id : int;
			var length : int = _items.length;
			var child : DisplayObject;
			var percentage : Number;
			var pos : Point;
			var refPos : Point;

			for (i = 0; i < length; i++)
			{
				id = (i + _startAt) % length;
				child = _items[id];
				percentage = i / (_path.closedPath ? length : length - 1);
				pos = _path.getPointAt(percentage);
				refPos = _path.getPointAt((percentage + .01) % 1);

				child.rotation = Math.atan2(refPos.y - pos.y, refPos.x - pos.x) * (180 / Math.PI) + angleOffset;
			}
			return this;
		}

		// ----------------------------------------------------
		// GETTERS AND SETTERS
		// ----------------------------------------------------
		/**
		 * Path instance
		 */
		public function get path() : IPath
		{
			return _path;
		}
		
		/**
		 * Offset position for the children
		 */
		public function set offset(value : Point) : void
		{
			_offset = value;
			distribute(_startAt);
		}
		
		public function get offset() : Point
		{
			return _offset;
		}
	}
}