package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import flair.resources.getDrawable;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.utils.Color;
	import starling.utils.MenuButton;
	import starling.utils.deg2rad;

	public class AnimationScreen extends BaseScreen
	{
		private var _startButton : MenuButton;
		private var _delayButton : MenuButton;
		private var _egg : Image;
		private var _transitionLabel : Label;
		private var _transitions : Array;
		private var _eggGroup : LayoutGroup;

		public function AnimationScreen()
		{
			_transitions = [ Transitions.LINEAR , Transitions.EASE_IN_OUT , Transitions.EASE_OUT_BACK , Transitions.EASE_OUT_BOUNCE , Transitions.EASE_OUT_ELASTIC ];
		}

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();

			var l : VerticalLayout = new VerticalLayout();
			l.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			l.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			l.gap = R.dimen.gap * 2;
			l.padding = R.dimen.screen_padding;
			_content.layout = l;

			var buttonLayout : VerticalLayout = new VerticalLayout();
			buttonLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			buttonLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			buttonLayout.gap = R.dimen.gap * 2;
			var buttonGroup : LayoutGroup = new LayoutGroup();
			buttonGroup.layout = buttonLayout;

			// create a button that starts the tween
			_startButton = new MenuButton( "Start animation" );
			_startButton.addEventListener( Event.TRIGGERED , onStartButtonTriggered );
			buttonGroup.addChild( _startButton );

			// this button will show you how to call a method with a delay
			_delayButton = new MenuButton( "Delayed call" );
			_delayButton.addEventListener( Event.TRIGGERED , onDelayButtonTriggered );
			buttonGroup.addChild( _delayButton );

			_content.addChild( buttonGroup );

			_eggGroup = new LayoutGroup();
			_eggGroup.layout = new AnchorLayout();
			_eggGroup.layoutData = new VerticalLayoutData( 100 , 100 );
			// the Starling will be tweened
			_egg = new Image( getDrawable( "starling_front" ) );
			_eggGroup.addChild( _egg );
			resetEgg();

			_transitionLabel = new Label();
			_transitionLabel.fontStyles = new TextFormat( Fonts.UBUNTU , 20 );
			_transitionLabel.fontStyles.bold = true;
			_transitionLabel.alpha = 0.0; // invisible, will be shown later
			_transitionLabel.layoutData = new AnchorLayoutData( 0 , 0 , NaN , 0 );
			_eggGroup.addChild( _transitionLabel );

			_content.addChild( _eggGroup );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
				_eggGroup.minWidth = actualWidth - R.dimen.screen_padding * 2;

			super.draw();
		}

		private function resetEgg() : void
		{
			_egg.x = 0;
			_egg.y = 0;
			_egg.scaleX = _egg.scaleY = 1.0;
			_egg.rotation = 0.0;
		}

		private function onStartButtonTriggered() : void
		{
			_startButton.isEnabled = false;
			_startButton.alpha = .5;
			resetEgg();

			// get next transition style from array and enqueue it at the end
			var transition : String = _transitions.shift();
			_transitions.push( transition );

			// to animate any numeric property of an arbitrary object (not just display objects!),
			// you can create a 'Tween'. One tween object animates one target for a certain time,
			// a with certain transition function.
			var tween : Tween = new Tween( _egg , 2.0 , transition );
			var scale : Number = .5;
			// you can animate any property as long as it's numeric (int, uint, Number).
			// it is animated from it's current value to a target value.
			tween.animate( "rotation" , deg2rad( 90 ) ); // conventional 'animate' call
			tween.moveTo( _eggGroup.width , _eggGroup.height - _egg.width * scale );                 // convenience method for animating 'x'
			// and 'y'
			tween.scaleTo( scale );                     // convenience method for 'scaleX' and 'scaleY'
			tween.onComplete = function () : void
			{
				_startButton.isEnabled = true;
				_startButton.alpha = 1.0;
			};

			// the tween alone is useless -- for an animation to be carried out, it has to be
			// advance once in every frame.
			// This is done by the 'Juggler'. It receives the tween and will carry it out.
			// We use the default juggler here, but you can create your own jugglers, as well.
			// That way, you can group animations into logical parts.
			Starling.juggler.add( tween );

			// show which tweening function is used
			_transitionLabel.text = transition;
			_transitionLabel.alpha = 1.0;

			var hideTween : Tween = new Tween( _transitionLabel , 2.0 , Transitions.EASE_IN );
			hideTween.animate( "alpha" , 0.0 );
			Starling.juggler.add( hideTween );
		}

		private function onDelayButtonTriggered() : void
		{
			_delayButton.isEnabled = false;
			_delayButton.alpha = 0.5;

			// Using the juggler, you can delay a method call. This is especially useful when
			// you use your own juggler in a component of your game, because it gives you perfect
			// control over the flow of time and animations.

			Starling.juggler.delayCall( colorizeEgg , 1.0 , true );
			Starling.juggler.delayCall( colorizeEgg , 2.0 , false );
			Starling.juggler.delayCall( function () : void
			{
				_delayButton.isEnabled = true;
				_delayButton.alpha = 1.0;
			} , 2.0 );
		}

		private function colorizeEgg( colorize : Boolean ) : void
		{
			_egg.color = colorize ? Color.RED : Color.WHITE;
		}

		public override function dispose() : void
		{
			_startButton.removeEventListener( Event.TRIGGERED , onStartButtonTriggered );
			_delayButton.removeEventListener( Event.TRIGGERED , onDelayButtonTriggered );
			super.dispose();
		}
	}
}