package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import flair.resources.getDrawable;

	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.utils.MenuButton;

	public class BlendModeScreen extends BaseScreen
	{
		private var _button : MenuButton;
		private var _image : Image;
		private var _infoText : Label;

		private var _blendModes : Array = [ BlendMode.NORMAL , BlendMode.MULTIPLY , BlendMode.SCREEN , BlendMode.ADD , BlendMode.ERASE , BlendMode.NONE ];

		public function BlendModeScreen()
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

			_button = new MenuButton( R.string.blend_mode_switch_mode );
			_button.addEventListener( Event.TRIGGERED , onButtonTriggered );
			_content.addChild( _button );

			var group : LayoutGroup = new LayoutGroup();
			var l2 : VerticalLayout = new VerticalLayout();
			l2.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			l2.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			l2.gap = R.dimen.gap * 2;
			group.layout = l2;
			group.layoutData = new VerticalLayoutData( NaN , 100 );

			_image = new Image( getDrawable( "starling_rocket" ) );
			group.addChild( _image );

			_infoText = new Label();
			_infoText.fontStyles = new TextFormat( Fonts.UBUNTU , 19 );
			group.addChild( _infoText );

			_content.addChild( group );

			onButtonTriggered();
		}

		private function onButtonTriggered() : void
		{
			var blendMode : String = _blendModes.shift() as String;
			_blendModes.push( blendMode );

			_infoText.text = blendMode;
			_image.blendMode = blendMode;
		}
	}
}