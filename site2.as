/*	
	====================================================================================
	2008 | John Dalziel  | The Computus Engine  |  http://www.computus.org

	All source code licenced under The MIT Licence
	====================================================================================  
	
	Animated Main Preloader in AS3
*/

package 
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.MovieClip;
	import flash.events.*;

	public class MainPreloader extends MovieClip
	{
		
	// -----------------------------------------------------------------------------
	// PROPERTIES
	
		// private var preloader:MovieClip// instance of the progress animation movie on the main stage

	// -----------------------------------------------------------------------------
	// CONSTRUCTOR & DESTRUCTOR
		
		public function MainPreloader():void
		{
			super();
			init();
		}
		
		protected function init():void
		{
			// Stop main timeline
			stop();
			
			// init Stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			if ( this.loaderInfo.bytesLoaded == this.loaderInfo.bytesTotal )
			{
				// if already loaded
				onMainLoaded()
			}
			else
			{
				// if not then track load progress
				this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onMainLoadProgress);
			}
		}
		
		protected function destroy():void
		{
			// clean up listeners
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onMainLoadProgress);
		}
		
	// --------------------------------------------------------------
	// EVENTS
		
		protected function onMainLoadProgress(e:ProgressEvent):void
		{
			var percent:Number = Math.round((e.bytesLoaded / e.bytesTotal )*100 );
			preloader.gotoAndStop( percent );
			trace(percent + "%  loaded");

			// check for load complete
			if (e.bytesLoaded == e.bytesTotal )
			{
				onMainLoaded();
			}
		}
		
		protected function onMainLoaded():void
		{
			// Start main timeline
			destroy();
			play();
		}
	}
}