package starling.view
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import flair.resources.getDrawable;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.MenuButton;
	import starling.utils.StringUtil;

	public class BenchmarkScreen extends BaseScreen
	{
		private static const FRAME_TIME_WINDOW_SIZE : int = 10;
		private static const MAX_FAIL_COUNT : int = 100;

		private var _startButton : MenuButton;
		private var _resultText : Label;
		private var _statusText : Label;
		private var _container : LayoutGroup;
		private var _objectPool : Vector.<DisplayObject>;
		private var _objectTexture : Texture;

		private var _frameCount : int;
		private var _failCount : int;
		private var _started : Boolean;
		private var _frameTimes : Vector.<Number>;
		private var _targetFps : int;
		private var _phase : int;

		public function BenchmarkScreen()
		{
			super();
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

			_startButton = new MenuButton( R.string.start_benchmark );
			_startButton.addEventListener( Event.TRIGGERED , onStartButtonTriggered );
			_content.addChild( _startButton );

			_statusText = new Label();
			_statusText.textRendererFactory = function () : ITextRenderer
			{
				return new BitmapFontTextRenderer();
			};

			_statusText.fontStyles = new TextFormat( BitmapFont.MINI , 10 );

			// the container will hold all test objects
			_container = new LayoutGroup();
			_container.includeInLayout = false;
			_container.layoutData = new VerticalLayoutData( NaN , 100 );
			_container.touchable = false; // we do not need touch events on the test objects --
										  // thus, it is more efficient to disable them.
			addChild( _container );

			_started = false;
			_frameTimes = new <Number>[];
			_objectPool = new <DisplayObject>[];
			_objectTexture = getDrawable( "benchmark_object" );

			addEventListener( Event.ENTER_FRAME , onEnterFrame );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			if( isInvalid( INVALIDATION_FLAG_SIZE ) )
			{
				_container.x = actualWidth / 2;
				_container.y = actualHeight / 2;
			}

			super.draw();
		}

		override public function dispose() : void
		{
			removeEventListener( Event.ENTER_FRAME , onEnterFrame );
			_startButton.removeEventListener( Event.TRIGGERED , onStartButtonTriggered );

			for each ( var object : DisplayObject in _objectPool )
				object.dispose();

			super.dispose();
		}

		private function onStartButtonTriggered() : void
		{
			trace( "Starting benchmark" );

			_startButton.visible = false;
			_started = true;
			_targetFps = Starling.current.nativeStage.frameRate;
			_frameCount = 0;
			_failCount = 0;
			_phase = 0;

			for( var i : int = 0; i < FRAME_TIME_WINDOW_SIZE; ++i )
				_frameTimes[ i ] = 1.0 / _targetFps;

			if( _resultText )
			{
				_resultText.removeFromParent( true );
				_resultText = null;
			}

			_content.addChild( _statusText );
			_content.removeChild( _startButton );
		}

		private function onEnterFrame( event : EnterFrameEvent , passedTime : Number ) : void
		{
			if( !_started ) return;

			_frameCount++;
			_container.rotation += event.passedTime * 0.5;
			_frameTimes[ FRAME_TIME_WINDOW_SIZE ] = 0.0;

			for( var i : int = 0; i < FRAME_TIME_WINDOW_SIZE; ++i )
				_frameTimes[ i ] += passedTime;

			const measuredFps : Number = FRAME_TIME_WINDOW_SIZE / _frameTimes.shift();

			if( _phase == 0 )
			{
				if( measuredFps < 0.985 * _targetFps )
				{
					_failCount++;

					if( _failCount == MAX_FAIL_COUNT )
						_phase = 1;
				}
				else
				{
					addTestObjects( 16 );
					_container.scale *= 0.99;
					_failCount = 0;
				}
			}
			if( _phase == 1 )
			{
				if( measuredFps > 0.99 * _targetFps )
				{
					_failCount--;

					if( _failCount == 0 )
						benchmarkComplete();
				}
				else
				{
					removeTestObjects( 1 );
					_container.scale /= 0.9993720513; // 0.99 ^ (1/16)
				}
			}

			if( _frameCount % int( _targetFps / 4 ) == 0 )
				_statusText.text = StringUtil.format( R.string.benchmark_object_count , _container.numChildren );
		}

		private function addTestObjects( count : int ) : void
		{
			var scale : Number = 1.0 / _container.scale;

			for( var i : int = 0; i < count; ++i )
			{
				var egg : DisplayObject = getObjectFromPool();
				var distance : Number = (100 + Math.random() * 100) * scale;
				var angle : Number = Math.random() * Math.PI * 2.0;

				egg.x = Math.cos( angle ) * distance;
				egg.y = Math.sin( angle ) * distance;
				egg.rotation = angle + Math.PI / 2.0;
				egg.scale = scale;

				_container.addChild( egg );
			}
		}

		private function removeTestObjects( count : int ) : void
		{
			var numChildren : int = _container.numChildren;

			if( count >= numChildren )
				count = numChildren;

			for( var i : int = 0; i < count; ++i )
				putObjectToPool( _container.removeChildAt( _container.numChildren - 1 ) );
		}

		private function getObjectFromPool() : DisplayObject
		{
			// we pool mainly to avoid any garbage collection while the benchmark is running

			if( _objectPool.length == 0 )
			{
				var image : Image = new Image( _objectTexture );
				image.alignPivot();
				image.pixelSnapping = false; // slightly faster (and doesn't work here, anyway)
				return image;
			}
			else
				return _objectPool.pop();
		}

		private function putObjectToPool( object : DisplayObject ) : void
		{
			_objectPool[ _objectPool.length ] = object;
		}

		private function benchmarkComplete() : void
		{
			_started = false;
			_startButton.visible = true;

			var fps : int = Starling.current.nativeStage.frameRate;
			var numChildren : int = _container.numChildren;
			var resultString : String = StringUtil.format( R.string.benchmark_result , numChildren , fps );
			trace( resultString.replace( /\n/g , " " ) );

			_content.removeChild( _statusText );
			_content.addChild( _startButton );

			_resultText = new Label();
			_resultText.wordWrap = true;
			_resultText.maxWidth = actualWidth;
			_resultText.text = resultString;
			_resultText.layoutData = new VerticalLayoutData( NaN , 100 );
			_resultText.fontStyles = new TextFormat( Fonts.UBUNTU , 30 );

			_content.addChild( _resultText );

			_container.scale = 1.0;
			_frameTimes.length = 0;
			_statusText.text = "";

			for( var i : int = numChildren - 1; i >= 0; --i )
				putObjectToPool( _container.removeChildAt( i ) );
		}
	}
}