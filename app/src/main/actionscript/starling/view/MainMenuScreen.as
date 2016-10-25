package starling.view
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalAlign;

	import flair.resources.getDrawable;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.utils.MenuButton;
	import starling.utils.ScaleMode;

	public class MainMenuScreen extends Screen
	{
		public function MainMenuScreen()
		{

		}

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();

			layout = new AnchorLayout();

			var logo : ImageLoader = new ImageLoader();
			logo.scaleMode = ScaleMode.NO_BORDER;
			logo.source = getDrawable( "logo" );
			logo.layoutData = new AnchorLayoutData( 0 , 0 , NaN , 0 );
			addChild( logo );

			// show information about rendering method (hardware/software)
			var driverInfo : String = Starling.context.driverInfo;
			var infoText : Label = new Label();
			infoText.text = driverInfo;
			infoText.padding = R.dimen.gap;
			infoText.fontStyles = new TextFormat( Fonts.UBUNTU , 10 );
			infoText.layoutData = new AnchorLayoutData( NaN , 0 , 0 , 0 );

			var buttonGroup : LayoutGroup = new LayoutGroup();
			var buttonLayout : TiledRowsLayout = new TiledRowsLayout();
			buttonLayout.horizontalGap = R.dimen.gap * 2;
			buttonLayout.verticalGap = R.dimen.gap;
			buttonLayout.padding = R.dimen.screen_padding;
			buttonLayout.paddingTop = 0;
			buttonLayout.distributeWidths = true;
			buttonLayout.distributeHeights = true;
			buttonLayout.useSquareTiles = false;
			buttonLayout.requestedColumnCount = 2;
			buttonLayout.tileHorizontalAlign = HorizontalAlign.JUSTIFY;
			buttonLayout.verticalAlign = VerticalAlign.MIDDLE;
			buttonGroup.layout = buttonLayout;
			var data : AnchorLayoutData = new AnchorLayoutData( 0 , 0 , 0 , 0 );
			data.topAnchorDisplayObject = logo;
			data.bottomAnchorDisplayObject = infoText;
			buttonGroup.layoutData = data;

			var scenesToCreate : Array = [ ScreenID.TEXTURE , ScreenID.TOUCH , ScreenID.TEXT , ScreenID.ANIMATION , ScreenID.CUSTOM_HIT_TEST , ScreenID.MOVIE , ScreenID.FILTER , ScreenID.BLEND_MODE , ScreenID.RENDER_TEXTURE , ScreenID.BENCHMARK , ScreenID.MASK , ScreenID.SPRITE3D ];

			for each ( var sceneToCreate : String in scenesToCreate )
			{
				var button : MenuButton = new MenuButton( R.string[ sceneToCreate ] );
				button.name = sceneToCreate;
				button.addEventListener( Event.TRIGGERED , function ( e : Event ) : void
				{
					dispatchEventWith( ( e.currentTarget as Button ).name + "Screen" );
				} );
				buttonGroup.addChild( button );
			}

			addChild( buttonGroup );
			addChild( infoText );
		}
	}
}