package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import flair.resources.getDrawable;

	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.DisplacementMapFilter;
	import starling.filters.DropShadowFilter;
	import starling.filters.FilterChain;
	import starling.filters.FragmentFilter;
	import starling.filters.GlowFilter;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.MenuButton;

	public class FilterScreen extends BaseScreen
	{
		private var _button : MenuButton;
		private var _image : Image;
		private var _infoText : Label;
		private var _filterInfos : Array;
		private var _displacementMap : Texture;

		public function FilterScreen()
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

			_button = new MenuButton( R.string.filter_switch );
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

			initFilters();
			onButtonTriggered();
		}

		override public function dispose() : void
		{
			_displacementMap.dispose();
			super.dispose();
		}

		private function onButtonTriggered() : void
		{
			var filterInfo : Array = _filterInfos.shift() as Array;
			_filterInfos.push( filterInfo );

			_infoText.text = filterInfo[ 0 ];
			_image.filter = filterInfo[ 1 ];
		}

		private function initFilters() : void
		{
			_filterInfos = [ [ R.string.filter_identity , new FragmentFilter() ] , [ R.string.filter_blur , new BlurFilter() ] , [ R.string.filter_shadow , new DropShadowFilter() ] , [ R.string.filter_glow , new GlowFilter() ] ];

			_displacementMap = createDisplacementMap( _image.width , _image.height );

			var displacementFilter : DisplacementMapFilter = new DisplacementMapFilter( _displacementMap , BitmapDataChannel.RED , BitmapDataChannel.GREEN , 25 , 25 );
			_filterInfos.push( [ R.string.filter_displacement , displacementFilter ] );

			var invertFilter : ColorMatrixFilter = new ColorMatrixFilter();
			invertFilter.invert();
			_filterInfos.push( [ R.string.filter_invert , invertFilter ] );

			var grayscaleFilter : ColorMatrixFilter = new ColorMatrixFilter();
			grayscaleFilter.adjustSaturation( -1 );
			_filterInfos.push( [ R.string.filter_gray_scale , grayscaleFilter ] );

			var saturationFilter : ColorMatrixFilter = new ColorMatrixFilter();
			saturationFilter.adjustSaturation( 1 );
			_filterInfos.push( [ R.string.filter_saturation , saturationFilter ] );

			var contrastFilter : ColorMatrixFilter = new ColorMatrixFilter();
			contrastFilter.adjustContrast( 0.75 );
			_filterInfos.push( [ R.string.filter_contrast , contrastFilter ] );

			var brightnessFilter : ColorMatrixFilter = new ColorMatrixFilter();
			brightnessFilter.adjustBrightness( -0.25 );
			_filterInfos.push( [ R.string.filter_brightness , brightnessFilter ] );

			var hueFilter : ColorMatrixFilter = new ColorMatrixFilter();
			hueFilter.adjustHue( 1 );
			_filterInfos.push( [ R.string.filter_hue , hueFilter ] );

			var chain : FilterChain = new FilterChain( hueFilter , new DropShadowFilter() );
			_filterInfos.push( [ R.string.filter_hue_shadow , chain ] );
		}

		private function createDisplacementMap( width : Number , height : Number ) : Texture
		{
			var scale : Number = Starling.contentScaleFactor;
			var map : BitmapData = new BitmapData( width * scale , height * scale , false );
			map.perlinNoise( 20 * scale , 20 * scale , 3 , 5 , false , true );
			var texture : Texture = Texture.fromBitmapData( map , false , false , scale );
			return texture;
		}
	}
}