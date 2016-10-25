package starling.view
{
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;

	import flair.resources.getDrawable;

	import flash.geom.Point;
	import flash.utils.Dictionary;

	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.utils.MenuButton;

	public class RenderTextureScreen extends BaseScreen
	{
		private var _renderTexture : RenderTexture;
		private var _canvas : Image;
		private var _canvasContainer : LayoutGroup;
		private var _brush : Image;
		private var _button : MenuButton;
		private var _colors : Dictionary;

		public function RenderTextureScreen()
		{
			_colors = new Dictionary();
			_renderTexture = new RenderTexture( 320 , 435 );
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

			_canvasContainer = new LayoutGroup();
			_canvas = new Image( _renderTexture );
			_canvas.addEventListener( TouchEvent.TOUCH , onTouch );
			_canvasContainer.addChild( _canvas );
			_canvasContainer.includeInLayout = false;
			_content.addChildAt( _canvasContainer , 0 );

			_button = new MenuButton( R.string.render_texture_draw );
			_button.addEventListener( Event.TRIGGERED , onButtonTriggered );
			_content.addChild( _button );

			_brush = new Image( getDrawable( "brush" ) );
			_brush.pivotX = _brush.width / 2;
			_brush.pivotY = _brush.height / 2;
			_brush.blendMode = BlendMode.NORMAL;
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
			{
				var renderTexture : RenderTexture = new RenderTexture( actualWidth , actualHeight );
				var infoText : TextField = new TextField( 256 , 128 , R.string.render_texture_help );
				infoText.isHtmlText = true;
				infoText.format.size = 24;
				infoText.x = ( actualWidth - infoText.width ) / 2;
				infoText.y = ( actualHeight - infoText.height ) / 2;
				renderTexture.draw( infoText );
				infoText.dispose();

				renderTexture.draw( new Image( _renderTexture ) );
				_renderTexture.dispose();
				_renderTexture = renderTexture;

				_canvasContainer.removeChildren();
				_canvas.removeEventListener( TouchEvent.TOUCH , onTouch );
				_canvas = new Image( _renderTexture );
				_canvas.addEventListener( TouchEvent.TOUCH , onTouch );
				_canvasContainer.addChild( _canvas );
			}

			super.draw();
		}

		private function onTouch( event : TouchEvent ) : void
		{
			// touching the canvas will draw a brush texture. The 'drawBundled' method is not
			// strictly necessary, but it's faster when you are drawing with several fingers
			// simultaneously.

			_renderTexture.drawBundled( function () : void
			{
				var touches : Vector.<Touch> = event.getTouches( _canvas );

				for each ( var touch : Touch in touches )
				{
					if( touch.phase == TouchPhase.BEGAN )
						_colors[ touch.id ] = Math.random() * uint.MAX_VALUE;

					if( touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED )
						continue;

					var location : Point = touch.getLocation( _canvas );
					_brush.x = location.x;
					_brush.y = location.y;
					_brush.color = _colors[ touch.id ];
					_brush.rotation = Math.random() * Math.PI * 2.0;

					_renderTexture.draw( _brush );

					// necessary because 'Starling.skipUnchangedFrames == true'
					setRequiresRedraw();
				}
			} );
		}

		private function onButtonTriggered() : void
		{
			if( _brush.blendMode == BlendMode.NORMAL )
			{
				_brush.blendMode = BlendMode.ERASE;
				_button.label = R.string.render_texture_erase;
			}
			else
			{
				_brush.blendMode = BlendMode.NORMAL;
				_button.label = R.string.render_texture_draw;
			}
		}

		public override function dispose() : void
		{
			_renderTexture.dispose();
			super.dispose();
		}
	}
}