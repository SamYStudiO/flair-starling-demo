package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;

	import flair.resources.getDrawable;

	import starling.display.Image;
	import starling.text.TextFormat;
	import starling.utils.TouchSheet;
	import starling.utils.deg2rad;

	public class TouchScreen extends BaseScreen
	{
		private var _sheet : TouchSheet;

		public function TouchScreen()
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
			l.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			l.padding = R.dimen.screen_padding;
			_content.layout = l;

			var infoText : Label = new Label();
			infoText.fontStyles = new TextFormat( Fonts.UBUNTU );
			infoText.text = R.string.touch_help;
			infoText.x = infoText.y = 10;
			_content.addChild( infoText );

			// to find out how to react to touch events have a look at the TouchSheet class!
			// It's part of the demo.

			var group : LayoutGroup = new LayoutGroup();
			group.includeInLayout = false;
			_sheet = new TouchSheet( new Image( getDrawable( "starling_sheet" ) ) );
			_sheet.rotation = deg2rad( 10 );
			group.addChild( _sheet );
			_content.addChild( group );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
			{
				_sheet.x = actualWidth / 2;
				_sheet.y = actualHeight / 2;
			}

			super.draw();
		}
	}
}