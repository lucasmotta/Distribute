package com.lucasmotta.core
{

	import flash.display.Graphics;
	import flash.geom.Point;
	/**
	 * @author Lucas Motta - http://lucasmotta.com
	 */
	public interface IPath
	{
		
		function getPointAt(progress : Number) : Point
		
		function get length() : int
		
		function get closedPath() : Boolean
		
		function set graphics(value : Graphics) : void
	}
}
