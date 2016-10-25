package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import flair.resources.getDrawable;

	import starling.text.TextFormat;
	import starling.utils.RoundButton;

	public class CustomHitTestScreen extends BaseScreen
	{
		private var _infoText : Label;

		public function CustomHitTestScreen()
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

			_infoText = new Label();
			_infoText.fontStyles = new TextFormat( Fonts.UBUNTU );
			_infoText.wordWrap = true;
			_infoText.text = R.string.custom_hit_description;
			_content.addChild( _infoText );

			var group : LayoutGroup = new LayoutGroup();
			group.layoutData = new VerticalLayoutData( NaN , 100 );
			var l2 : VerticalLayout = new VerticalLayout();
			l2.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			group.layout = l2;
			// 'RoundButton' is a helper class of the Demo, not a part of Starling!
			// Have a look at its code to understand this sample.
			var button : RoundButton = new RoundButton( getDrawable( "starling_round" ) );
			group.addChild( button );
			_content.addChild( group );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
				_infoText.maxWidth = actualWidth - R.dimen.screen_padding * 2;

			super.draw();
		}
	}
}