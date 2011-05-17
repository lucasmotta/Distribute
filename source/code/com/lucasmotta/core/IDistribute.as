package com.lucasmotta.core
{

	import flash.geom.Point;
	/**
	 * @author Lucas Motta - http://lucasmotta.com
	 */
	public interface IDistribute
	{
		
		function distribute(startAt : int = 0) : IDistribute
		
		function orientToPath(offsetAngle : Number = 0) : IDistribute
		
		
		function get path() : IPath
		
		function get offset() : Point
		
		function set offset(value : Point) : void
	}
}
