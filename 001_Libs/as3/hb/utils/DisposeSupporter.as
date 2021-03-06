﻿/**
	@Name: DisposeSupporter  ver 1.12
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2013-02-18
	@Comments:
	{
		This class is for improving the performance of Flash Player Garbage Collection tool.
		Just by using a simple application of performance importance.
	}
	@Using:
	{

		import hb.utils.DisposeSupporter;

		// - Detail clear at DisplayObjectContainer
		DisposeSupporter.containerDetailClear(container, true, true);
		// - Detail clear at DisplayObject
		DisposeSupporter.displayObjectDispose(container, true, true);
		// - Simple clear at DisplayObject
		DisposeSupporter.containerClear(container);
		// - Garbage Collection Call
		DisposeSupporter.gc();

		// - Detail clear at Loader
		DisposeSupporter.loaderDispose(loader, true, true);
		// - Detail clear at Bitmap
		DisposeSupporter.bitmapDispose(bimap);
		// - Detail clear at Bitmap
		DisposeSupporter.simpleButtonDispose(simpleButton, true, true);
		// - Detail clear at shape
		DisposeSupporter.shapeDispose(shape);

	}
*/
package hb.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	import hb.utils.DebugUtil;

	public final class DisposeSupporter
	{
		public function DisposeSupporter()
		{
		}

		// :: Loader optimized in garbage collection
		public static function loaderDispose(target:Loader, isSub:Boolean = false,
												isDetail:Boolean = true, gc:Boolean = true):void
		{
			var t_do:DisplayObject = target.content;

			if (t_do != null)
			{
				displayObjectDispose(t_do, isSub, isDetail);

				if (isDetail)
					target.unloadAndStop(gc);
				else
					target.unload();

				//DebugUtil.test('loaderDispose');
			}

		}

		// :: Bitmap object disposed
		public static function bitmapDispose(target:Bitmap):void
		{
			try
			{
				if (target.bitmapData != null)
					target.bitmapData.dispose();

				//DebugUtil.test('bitmapDispose');
			}
			catch (e:Error)
			{
			}
		}

		// :: SimpleButton
		public static function simpleButtonDispose(target:SimpleButton, isSub:Boolean = false, isDetail:Boolean = false):void
		{

			if (target.upState != null)
				displayObjectDispose(target.upState, isSub, isDetail);
			if (target.overState != null)
				displayObjectDispose(target.overState, isSub, isDetail);
			if (target.downState != null)
				displayObjectDispose(target.downState, isSub, isDetail);
			if (target.hitTestState != null)
				displayObjectDispose(target.hitTestState, isSub, isDetail);

			//trace('button '+target.upState);
			//trace('button '+target.overState);
			//trace('button '+target.downState);
			//trace('button '+target.hitTestState);

			//DebugUtil.test('simpleButtonDispose');

		}

		// ::
		public static function shapeDispose(target:Shape):void
		{
			target.graphics.clear();

			//DebugUtil.test('shapeDispose');

		}

		// ::
		public static function displayObjectDispose(target:DisplayObject, isSub:Boolean = false, isDetail:Boolean = false):void
		{
			if (isSub)
			{
				if (target is DisplayObjectContainer)
				{
					if (isDetail)
					{
						containerDetailClear(DisplayObjectContainer(target));
					}
					else
					{
						containerClear(DisplayObjectContainer(target));
					}
				}
			}

			if (target is Bitmap)
			{
				bitmapDispose(Bitmap(target));
			}
			else if (target is Loader)
			{
				loaderDispose(Loader(target), isSub, isDetail);
			}
			else if (target is MovieClip)
			{
				MovieClip(target).gotoAndStop(1);
			}
			else if (target is SimpleButton)
			{
				simpleButtonDispose(SimpleButton(target), isSub, isDetail);
			}
			else if (target is Shape)
			{
				shapeDispose(Shape(target));
			}

			//DebugUtil.test('displayObjectDispose');

		}

		// :: DisplayObjectContainer of removed childs
		public static function containerClear(target:DisplayObjectContainer, isSub:Boolean = false):void
		{
			var t_do:DisplayObject = null;
			var t_len:uint = target.numChildren, i:int;

			try
			{
				i = 0;

				while (i < t_len)
				{
					t_do = target.getChildAt(0);

					if (isSub)
					{
						if (t_do is DisplayObjectContainer)
							containerClear(DisplayObjectContainer(t_do), isSub);
					}

					target.removeChild(t_do);

					i ++;
				}
			}
			catch (e:Error)
			{
			}

			//DebugUtil.test('containerClear');
		}

		// :: DisplayObjectContainer of removed childs strong
		public static function containerDetailClear(target:DisplayObjectContainer,
													isSub:Boolean = false, isDetail:Boolean = false):void
		{
			var t_do:DisplayObject = null;
			var t_len:uint = target.numChildren, i:int;

			try
			{
				i = 0;

				while (i < t_len)
				{
					t_do = target.getChildAt(0);

					displayObjectDispose(t_do, isSub, isDetail);

					target.removeChild(t_do);

					i ++;
				}
			}
			catch (e:Error)
			{
			}

			//DebugUtil.test('containerDetailClear');
		}

		// ::
		public static function disposeXML(node:XML):void
		{
			System.disposeXML(node);

			//DebugUtil.test('disposeXML');
		}

		// ::
		public static function clearClipboard():void
		{
			System.setClipboard('');

			//DebugUtil.test('clearClipboard');
		}

		// ::
		public static function byteArrayClear(ba:ByteArray):void
		{
			ba.clear();

			//DebugUtil.test('byteArrayClear');
		}

		// ::
		public static function gc():void
		{
			if
			(
				(Capabilities.playerType == 'Desktop') ||
				(Capabilities.isDebugger)
			)
			{
				try
				{
					System.gc();
				}
				catch (e:Error)
				{
				}

				if (isCautionTrace)
					DebugUtil.test('System.gc Call~!');
			}
			else
			{
				try
				{
				   new LocalConnection().connect('foo');
				   new LocalConnection().connect('foo');
				}
				catch (e:Error)
				{
				}

				if (isCautionTrace)
					DebugUtil.test('LocalConnection Create');
			}

			//DebugUtil.test('gc');
		}


		public static var isCautionTrace:Boolean = false;
	}

}