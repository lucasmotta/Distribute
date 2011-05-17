package com.lucasmotta.layout
{

	import com.lucasmotta.core.IPath;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author			Lucas Motta - http://lucasmotta.com
	 * @version			1.0
	 * @since			May 17, 2011
	 * 
	 * Create multiple paths to build something more complex
	 */
	public class MultiPath extends Sprite implements IPath
	{

		// ----------------------------------------------------
		// PRIVATE AND PROTECTED VARIABLES
		// ----------------------------------------------------
		protected var _paths : Vector.<Path>;

		protected var _length : Number;

		protected var _graphics : Graphics;


		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 */
		public function MultiPath()
		{
			_paths = new Vector.<Path>();
			_length = 0;
		}

		// ----------------------------------------------------
		// PRIVATE AND PROTECTED METHODS
		// ----------------------------------------------------
		/**
		 * The length of all paths together
		 */
		protected function getLength() : void
		{
			var i : int;
			var length : int = _paths.length;
			var distance : Number = 0;

			if (length == 0)
			{
				_length = 0;
				return;
			}

			for (i = 0; i < length; i++)
			{
				distance += _paths[i].length;
			}
			_length = distance;
		}

		// ----------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------
		/**
		 * Add a new path
		 * 
		 * @param path			Self explanatory :)
		 * @return				The multi path class
		 */
		public function add(path : Path) : MultiPath
		{
			_paths.push(path);

			getLength();

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
			var i : int;
			var length : int = _paths.length;
			var totalProgress : Number = 0;
			var pointProgress : Number;
			var targetPoint : Point;

			for (i = 0; i < length; i++)
			{
				pointProgress = _paths[i].length / _length;
				totalProgress += pointProgress;
				if (totalProgress >= progress)
				{
					targetPoint = _paths[i].getPointAt(1 - (totalProgress - progress) / pointProgress);
					break;
				}
			}
			return targetPoint;
		}

		// ----------------------------------------------------
		// GETTERS AND SETTERS
		// ----------------------------------------------------
		/**
		 * Length of all paths
		 */
		public function get length() : int
		{
			return _length;
		}

		public function get closedPath() : Boolean
		{
			return false;
		}

		/**
		 * Set a graphic to draw the path
		 */
		public function set graphics(value : Graphics) : void
		{
			_graphics = value;
			for each (var path : Path in _paths)
			{
				path.graphics = _graphics;
			}
		}
	}
}
