package com.lucasmotta.layout
{

	import flash.geom.Point;

	/**
	 * @author			Lucas Motta - http://lucasmotta.com
	 * @version			1.0
	 * @since			May 17, 2011
	 * 
	 * Alignment constants and methods
	 */
	public class DistributeAlign
	{

		// ----------------------------------------------------
		// PUBLIC STATIC CONST
		// ----------------------------------------------------
		public static const TOP : String = "top";

		public static const TOP_LEFT : String = "topLeft";

		public static const TOP_RIGHT : String = "topRight";

		public static const BOTTOM : String = "bottom";

		public static const BOTTOM_LEFT : String = "bottomLeft";

		public static const BOTTOM_RIGHT : String = "bottomRight";

		public static const LEFT : String = "left";

		public static const RIGHT : String = "right";


		// ----------------------------------------------------
		// PUBLIC STATIC METHODS
		// ----------------------------------------------------
		/**
		 * Get a offset point based on the alignment
		 * 
		 * @param width			Width of the path
		 * @param height		Height of the path
		 * @param align			Type of the alignment
		 * 
		 * @return				A Point
		 */
		public static function getOffset(width : Number, height : Number, align : String) : Point
		{
			switch(align)
			{
				case DistributeAlign.TOP :
					return new Point(0, height * .5);
					break;
				case DistributeAlign.TOP_LEFT :
					return new Point(width * .5, height * .5);
					break;
				case DistributeAlign.TOP_RIGHT :
					return new Point(-width * .5, height * .5);
					break;
				case DistributeAlign.BOTTOM :
					return new Point(0, -height * .5);
					break;
				case DistributeAlign.BOTTOM_LEFT :
					return new Point(width * .5, -height * .5);
					break;
				case DistributeAlign.BOTTOM_RIGHT :
					return new Point(-width * .5, -height * .5);
					break;
				case DistributeAlign.LEFT :
					return new Point(width * .5, 0);
					break;
				case DistributeAlign.RIGHT :
					return new Point(-width * .5, 0);
					break;
				default :
					return new Point();
			}
			return new Point();
		}
	}
}
