package starling.view
{
	import feathers.controls.LayoutGroup;

	import flair.logging.debug;
	import flair.resources.getDrawable;

	import flash.display3D.Context3DTriangleFace;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite3D;
	import starling.events.Event;
	import starling.rendering.Painter;
	import starling.textures.Texture;

	public class Sprite3DScreen extends BaseScreen
	{
		private var _cube : Sprite3D;

		public function Sprite3DScreen()
		{
		}

		/**
		 * @inheritDoc
		 */
		override protected function initialize() : void
		{
			super.initialize();
			var texture : Texture = getDrawable( "gamua-logo" );

			var group : LayoutGroup = new LayoutGroup();
			_cube = createCube( texture );
			_cube.z = 100;

			debug( this , "initialize" , _cube.width );
			group.includeInLayout = false;
			group.addChild( _cube );
			_content.addChild( group );

			if( stage != null ) start();
			else addEventListener( Event.ADDED_TO_STAGE , start );
			addEventListener( Event.REMOVED_FROM_STAGE , stop );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
			{
				_cube.x = actualWidth / 2;
				_cube.y = actualHeight / 2;
			}

			super.draw();
		}

		private function start() : void
		{
			Starling.juggler.tween( _cube , 6 , {rotationX : 2 * Math.PI , repeatCount : 0} );
			Starling.juggler.tween( _cube , 7 , {rotationY : 2 * Math.PI , repeatCount : 0} );
			Starling.juggler.tween( _cube , 8 , {rotationZ : 2 * Math.PI , repeatCount : 0} );
		}

		private function stop() : void
		{
			Starling.juggler.removeTweens( _cube );
		}

		private function createCube( texture : Texture ) : Sprite3D
		{
			var offset : Number = texture.width / 2;

			var front : Sprite3D = createSidewall( texture , 0xff0000 );
			front.z = -offset;

			var back : Sprite3D = createSidewall( texture , 0x00ff00 );
			back.rotationX = Math.PI;
			back.z = offset;

			var top : Sprite3D = createSidewall( texture , 0x0000ff );
			top.y = -offset;
			top.rotationX = Math.PI / -2.0;

			var bottom : Sprite3D = createSidewall( texture , 0xffff00 );
			bottom.y = offset;
			bottom.rotationX = Math.PI / 2.0;

			var left : Sprite3D = createSidewall( texture , 0xff00ff );
			left.x = -offset;
			left.rotationY = Math.PI / 2.0;

			var right : Sprite3D = createSidewall( texture , 0x00ffff );
			right.x = offset;
			right.rotationY = Math.PI / -2.0;

			var cube : Sprite3D = new Sprite3D();
			cube.addChild( front );
			cube.addChild( back );
			cube.addChild( top );
			cube.addChild( bottom );
			cube.addChild( left );
			cube.addChild( right );

			return cube;
		}

		private function createSidewall( texture : Texture , color : uint = 0xffffff ) : Sprite3D
		{
			var image : Image = new Image( texture );
			image.color = color;
			image.alignPivot();

			var sprite : Sprite3D = new Sprite3D();
			sprite.addChild( image );

			return sprite;
		}

		public override function render( painter : Painter ) : void
		{
			// Starling does not make any depth-tests, so we use a trick in order to only show
			// the front quads: we're activating backface culling, i.e. we hide triangles at which
			// we look from behind.

			painter.pushState();
			painter.state.culling = Context3DTriangleFace.BACK;
			super.render( painter );
			painter.popState();
		}
	}
}