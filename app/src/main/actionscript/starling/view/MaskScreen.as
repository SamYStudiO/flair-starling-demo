package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;

	import flair.resources.getDrawable;

	import flash.geom.Point;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextFormat;

	public class MaskScreen extends BaseScreen
	{
		//private var _contents : Sprite;
		private var _mask : Canvas;
		private var _maskText : Label;
		private var _maskDisplay : Canvas;

		public function MaskScreen()
		{
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
			_content.backgroundSkin = new Quad( 10 , 10 , 0xff0000 );
			_content.backgroundSkin.alpha = 0;

			var image : Image = new Image( getDrawable( "flight_00" ) );
			_content.addChild( image );

			// just to prove it works, use a filter on the image.
			var cm : ColorMatrixFilter = new ColorMatrixFilter();
			cm.adjustHue( -0.5 );
			image.filter = cm;

			_maskText = new Label();
			_maskText.wordWrap = true;
			_maskText.text = R.string.mask_help;
			_maskText.fontStyles = new TextFormat( Fonts.UBUNTU , 20 );
			_content.addChild( _maskText );

			var maskContainer : LayoutGroup = new LayoutGroup();
			maskContainer.includeInLayout = false;
			_maskDisplay = createCircle();
			_maskDisplay.alpha = 0.1;
			_maskDisplay.touchable = false;
			maskContainer.addChild( _maskDisplay );
			_content.addChild( maskContainer );

			_mask = createCircle();
			_content.mask = _mask;

			addEventListener( TouchEvent.TOUCH , onTouch );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
				_maskText.maxWidth = actualWidth - R.dimen.screen_padding * 2;

			super.draw();
		}

		private function onTouch( event : TouchEvent ) : void
		{
			var touch : Touch = event.getTouch( this , TouchPhase.HOVER ) || event.getTouch( this , TouchPhase.BEGAN ) || event.getTouch( this , TouchPhase.MOVED );

			if( touch )
			{
				var localPos : Point = touch.getLocation( this );
				_mask.x = _maskDisplay.x = localPos.x;
				_mask.y = _maskDisplay.y = localPos.y;
			}
		}

		private function createCircle() : Canvas
		{
			var circle : Canvas = new Canvas();
			circle.beginFill( 0xff0000 );
			circle.drawCircle( 0 , 0 , 100 );
			circle.endFill();
			return circle;
		}

	}
}