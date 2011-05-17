package
{

	import flash.display.JointStyle;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import com.lucasmotta.core.IDistribute;
	import com.lucasmotta.layout.Distribute;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author Lucas Motta - http://lucasmotta.com
	 */
	[SWF(backgroundColor="#99173C", frameRate="31", width="1000", height="700")]
	public class DistributeExample extends Sprite
	{
		
		// ----------------------------------------------------
		// PUBLIC VARIABLES
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// PRIVATE AND PROTECTED VARIABLES
		// ----------------------------------------------------
		protected var _items : Array;
		
		protected var _distribute : IDistribute;
		// ----------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------
		/**
		 * @constructor
		 */
		public function DistributeExample()
		{
			_items = [];
			
			setupPoints();
		}
		
		// ----------------------------------------------------
		// PRIVATE AND PROTECTED METHODS
		// ----------------------------------------------------
		protected function setupPoints() : void
		{
			var i : int;
			var length : int = 100;
			var sp : Sprite;
			
			for(i = 0; i < length; i++)
			{
				sp = new Sprite();
				sp.graphics.lineStyle(2, 0xFFFFFF, .5, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
				sp.graphics.moveTo(-2, -3);
				sp.graphics.lineTo(2, 0);
				sp.graphics.lineTo(-2, 3);
				addChild(sp);
				
				_items[_items.length] = sp;
			}
			
			//_distribute = Distribute.rectangle(_items, 400, 400);
			//_distribute = Distribute.polygon(_items, 5, 200);
			_distribute = Distribute.star(_items, 5, 100, 200);
			_distribute.offset = new Point(1000 * .5, 700 * .5);
			_distribute.orientToPath();
		}
		// ----------------------------------------------------
		// EVENT HANDLERS
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------
		
		// ----------------------------------------------------
		// GETTERS AND SETTERS
		// ----------------------------------------------------
	}
}
