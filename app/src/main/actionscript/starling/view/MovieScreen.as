package starling.view
{
	import feathers.layout.VerticalLayout;

	import flair.resources.getDrawables;
	import flair.resources.getSound;

	import flash.media.Sound;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;

	public class MovieScreen extends BaseScreen
	{
		private var _movie : MovieClip;

		public function MovieScreen()
		{
			// like any animation, the movie needs to be added to the juggler!
			// this is the recommended way to do that.
			addEventListener( Event.ADDED_TO_STAGE , onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE , onRemovedFromStage );
		}

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();

			var l : VerticalLayout = new VerticalLayout();
			l.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			l.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			l.padding = R.dimen.screen_padding;
			_content.layout = l;

			var frames : Vector.<Texture> = getDrawables( "flight" );
			_movie = new MovieClip( frames , 15 );

			// add sounds
			var stepSound : Sound = getSound( "wing_flap" );
			_movie.setFrameSound( 2 , stepSound );

			// move the clip to the center and add it to the stage
			_content.addChild( _movie );
		}

		private function onAddedToStage() : void
		{
			Starling.juggler.add( _movie );
		}

		private function onRemovedFromStage() : void
		{
			Starling.juggler.remove( _movie );
		}

		public override function dispose() : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE , onRemovedFromStage );
			removeEventListener( Event.ADDED_TO_STAGE , onAddedToStage );
			super.dispose();
		}
	}
}