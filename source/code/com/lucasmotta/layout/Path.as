package com.lucasmotta.layout
{

	import com.lucasmotta.core.IPath;

	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * @author			Lucas Motta - http://lucasmotta.com
	 * @version			1.0
	 * @since			May 17, 2011
	 * 
	 * An abstract class to create a path and to get positions on this path
	 */
	public class Path implements IPath
	{

		// ----------------------------------------------------
		// PRIVATE AND PROTECTED VARIABLES
		// ----------------------------------------------------
		protected var _points : Vector.<Point>;

		protected var _length : Number;

		protected var _offset : Point;

		protected var _graphics : Graphics;


		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 * 
		 * @param offset		Offset point
		 */
		public function Path(offset : Point = null)
		{
			_points = new Vector.<Point>();
			_length = 0;
			_offset = offset || new Point();
		}

		// ----------------------------------------------------
		// PRIVATE AND PROTECTED METHODS
		// ----------------------------------------------------
		/**
		 * If the graphics is availabe, draw the path on it
		 */
		protected function draw() : void
		{
			if (_graphics == null) return;

			_graphics.clear();
			_graphics.lineStyle(1, 0);

			if (_points.length <= 1) return;
			_graphics.moveTo(_points[0].x, _points[0].y);

			var i : int;
			var length : int = _points.length;

			for (i = 1; i < length; i++)
			{
				_graphics.lineTo(_points[i].x, _points[i].y);
			}
		}

		/**
		 * Get the length of the path
		 */
		protected function getLength() : void
		{
			var i : int;
			var length : int = _points.length;
			var distance : Number = 0;

			if (length <= 1)
			{
				_length = 0;
				return;
			}

			for (i = 1; i < length; i++)
			{
				distance += Point.distance(_points[i], _points[i - 1]);
			}
			_length = distance;
		}

		// ----------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------
		/**
		 * Add a new point to the path
		 * 
		 * @param point			Self explanatory :)
		 * @return				The path class
		 */
		public function add(point : Point) : Path
		{
			point.offset(_offset.x, _offset.y);
			_points.push(point);

			getLength();
			draw();

			return this;
		}

		/**
		 * Get a point on the path.
		 * 
		 * @param progress		A float number between 0 and 1. Where 0 is the begining and 1 is the end of the path.
		 * @return				A Point
		 */
		public function getPointAt(progress : Number) : Point
		{
			if (_points.length <= 2)
			{
				throw new Error("Your path should have at least three points to work.");
			}
			progress = Math.max(0, Math.min(1, progress));

			var i : int;
			var length : int = _points.length;
			var pointProgress : Number;
			var totalProgress : Number = 0;

			for (i = 1 ; i < length; i++)
			{
				pointProgress = Point.distance(_points[i], _points[i - 1]) / _length;
				totalProgress += pointProgress;
				if (totalProgress >= progress)
				{
					return Point.interpolate(_points[i - 1], _points[i], (totalProgress - progress) / pointProgress);
				}
			}
			return null;
		}

		// ----------------------------------------------------
		// GETTERS AND SETTERS
		// ----------------------------------------------------
		/**
		 * Length of the path
		 */
		public function get length() : int
		{
			return _length;
		}

		/**
		 * Return if it's a closed path or not (like a square, for example)
		 */
		public function get closedPath() : Boolean
		{
			return _points[0].equals(_points[_points.length - 1]);
		}

		/**
		 * Set an offset point to the path. Needed for the alignment.
		 */
		public function set offset(value : Point) : void
		{
			_offset = value;
		}

		/**
		 * Set a graphic to draw the path
		 */
		public function set graphics(value : Graphics) : void
		{
			_graphics = value;
			draw();
		}
	}
}
