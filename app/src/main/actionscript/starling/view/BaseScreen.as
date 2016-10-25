package starling.view
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import starling.events.Event;
	import starling.utils.MenuButton;

	public class BaseScreen extends Screen
	{
		protected var _content : LayoutGroup;
		private var _button : MenuButton;

		public function BaseScreen()
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
			layout = l;

			_content = new LayoutGroup();
			_content.layoutData = new VerticalLayoutData( 100 , 100 );
			addChild( _content );

			_button = new MenuButton( R.string.back );
			_button.addEventListener( Event.TRIGGERED , function ( e : Event ) : void
			{
				dispatchEventWith( Event.COMPLETE );
			} );
			addChild( _button );
		}

		/**
		 * @inheritDoc
		 */
		override protected function draw() : void
		{
			super.draw();

			_button.y += 12;
		}
	}
}