package starling.utils
{
	import feathers.controls.Button;

	import flair.resources.getDrawable;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.text.TextFormat;

	/** A simple button that uses "scale9grid" with a single texture. */
	public class MenuButton extends Button
	{
		public function MenuButton( text : String )
		{
			super();
			this.label = text;

			var background : Image = new Image( getDrawable( "button" ) );
			background.scale9Grid = new Rectangle( 12.5 , 12.5 , 20 , 20 );
			defaultSkin = background;
			padding = R.dimen.button_padding_left_right;
			paddingTop = R.dimen.button_padding_top_button;
			paddingBottom = R.dimen.button_padding_top_button;
			scaleWhenDown = .9;
			fontStyles = new TextFormat( Fonts.UBUNTU );
		}
	}
}
