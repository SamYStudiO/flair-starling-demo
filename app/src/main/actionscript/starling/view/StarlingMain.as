package starling.view
{
	import feathers.controls.ImageLoader;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.motion.Slide;

	import flair.controls.AResourceScrollScreen;
	import flair.resources.getDrawable;

	import starling.events.Event;
	import starling.utils.ScaleMode;

	/**
	 * App root screen, you should edit this to your convenience, depending on your needs you may extends
	 * AResourceScreen, AResourceScrollScreen or AResourcePanelScreen, each one will manage resources for you.
	 */
	public class StarlingMain extends AResourceScrollScreen
	{
		/**
		 *
		 */
		private var _navigator : StackScreenNavigator;

		/**
		 *
		 */
		public function StarlingMain()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();

			FeathersControl.defaultTextRendererFactory = function () : ITextRenderer
			{
				var tf : TextFieldTextRenderer = new TextFieldTextRenderer();
				tf.isHTML = true;

				return tf;
			};

			autoSizeMode = AUTO_SIZE_MODE_STAGE;
			layout = new AnchorLayout();

			var image : ImageLoader = new ImageLoader();
			image.scaleMode = ScaleMode.NO_BORDER;
			image.source = getDrawable( "background" );
			backgroundSkin = image;

			_navigator = new StackScreenNavigator();
			_navigator.pushTransition = Slide.createSlideLeftTransition();
			_navigator.popTransition = Slide.createSlideRightTransition();
			_navigator.addScreen( ScreenID.ANIMATION , new StackScreenNavigatorItem( AnimationScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.BENCHMARK , new StackScreenNavigatorItem( BenchmarkScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.BLEND_MODE , new StackScreenNavigatorItem( BlendModeScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.CUSTOM_HIT_TEST , new StackScreenNavigatorItem( CustomHitTestScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.FILTER , new StackScreenNavigatorItem( FilterScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.MAIN_MENU , new StackScreenNavigatorItem( MainMenuScreen , {
				animationScreen     : ScreenID.ANIMATION ,
				benchmarkScreen     : ScreenID.BENCHMARK ,
				blendModeScreen     : ScreenID.BLEND_MODE ,
				customHitTestScreen : ScreenID.CUSTOM_HIT_TEST ,
				filterScreen        : ScreenID.FILTER ,
				maskScreen          : ScreenID.MASK ,
				movieScreen         : ScreenID.MOVIE ,
				renderTextureScreen : ScreenID.RENDER_TEXTURE ,
				sprite3dScreen      : ScreenID.SPRITE3D ,
				textScreen          : ScreenID.TEXT ,
				textureScreen       : ScreenID.TEXTURE ,
				touchScreen         : ScreenID.TOUCH
			} ) );
			_navigator.addScreen( ScreenID.MASK , new StackScreenNavigatorItem( MaskScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.MOVIE , new StackScreenNavigatorItem( MovieScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.RENDER_TEXTURE , new StackScreenNavigatorItem( RenderTextureScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.SPRITE3D , new StackScreenNavigatorItem( Sprite3DScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.TEXT , new StackScreenNavigatorItem( TextScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.TEXTURE , new StackScreenNavigatorItem( TextureScreen , null , Event.COMPLETE ) );
			_navigator.addScreen( ScreenID.TOUCH , new StackScreenNavigatorItem( TouchScreen , null , Event.COMPLETE ) );
			_navigator.rootScreenID = ScreenID.MAIN_MENU;
			_navigator.layoutData = new AnchorLayoutData( 0 , 0 , 0 , 0 );

			addChild( _navigator );
		}
	}
}
