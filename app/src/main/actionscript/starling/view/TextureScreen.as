package starling.view
{
	import feathers.controls.LayoutGroup;

	import flair.resources.getDrawable;

	import starling.display.Image;
	import starling.textures.Texture;

	public class TextureScreen extends BaseScreen
	{
		private var _image1 : Image;
		private var _image2 : Image;
		private var _image3 : Image;
		private var _image4 : Image;

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();

			// the flight textures are actually loaded from an atlas texture.
			// the "AssetManager" class wraps it away for us.

			var group : LayoutGroup = new LayoutGroup();
			group.includeInLayout = false;
			_image1 = new Image( getDrawable( "flight_00" ) );
			group.addChild( _image1 );

			_image2 = new Image( getDrawable( "flight_04" ) );
			group.addChild( _image2 );

			_image3 = new Image( getDrawable( "flight_08" ) );
			group.addChild( _image3 );

			// display a compressed texture

			var compressedTexture : Texture = getDrawable( "compressed_texture" );
			_image4 = new Image( compressedTexture );
			group.addChild( _image4 );
			_content.addChild( group );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
			{
				_image3.x = actualWidth - _image3.width;
				_image3.y = -_image3.height / 4;
				_image2.x = actualWidth - _image2.width;
				_image2.y = _image1.y + _image1.height / 3;
				_image4.x = ( actualWidth - _image4.width ) / 2;
				_image4.y = _image2.y + _image2.height;
			}

			super.draw();
		}
	}
}