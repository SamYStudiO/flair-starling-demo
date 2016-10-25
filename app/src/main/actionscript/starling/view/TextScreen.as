package starling.view
{
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Align;
	import starling.utils.Color;

	public class TextScreen extends BaseScreen
	{
		public function TextScreen()
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
			l.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			l.padding = R.dimen.screen_padding;
			l.gap = R.dimen.gap;
			_content.layout = l;

			// TrueType fonts

			var offset : int = 10;
			var ttFont : String = Fonts.UBUNTU;
			var ttFontSize : int = 19;

			var colorTF : TextField = new TextField( 300 , 80 , R.string.text_border_color );
			colorTF.format.setTo( ttFont , ttFontSize , 0x33399 );
			colorTF.x = colorTF.y = offset;
			colorTF.border = true;
			_content.addChild( colorTF );

			var group : LayoutGroup = new LayoutGroup();
			var l2 : HorizontalLayout = new HorizontalLayout();
			l2.gap = R.dimen.gap * 2;
			group.layout = l2;
			var leftTF : TextField = new TextField( 145 , 80 , R.string.text_top_left );
			leftTF.isHtmlText = true;
			leftTF.format.setTo( ttFont , ttFontSize , 0x993333 );
			leftTF.format.horizontalAlign = Align.LEFT;
			leftTF.format.verticalAlign = Align.TOP;
			leftTF.x = offset;
			leftTF.y = colorTF.y + colorTF.height + offset;
			leftTF.border = true;
			group.addChild( leftTF );

			var rightTF : TextField = new TextField( 145 , 80 , R.string.text_bottom_right );
			rightTF.isHtmlText = true;
			rightTF.format.setTo( ttFont , ttFontSize , 0x208020 );
			rightTF.format.horizontalAlign = Align.RIGHT;
			rightTF.format.verticalAlign = Align.BOTTOM;
			rightTF.border = true;
			rightTF.x = 2 * offset + leftTF.width;
			rightTF.y = leftTF.y;
			group.addChild( rightTF );
			_content.addChild( group );

			var fontTF : TextField = new TextField( 300 , 80 , R.string.text_centered );
			fontTF.format.setTo( ttFont , ttFontSize );
			fontTF.x = offset;
			fontTF.y = leftTF.y + leftTF.height + offset;
			fontTF.border = true;
			fontTF.isHtmlText = true;
			_content.addChild( fontTF );

			// Bitmap fonts!

			// First, you will need to create a bitmap font texture.
			//
			// E.g. with this tool: www.angelcode.com/products/bmfont/ or one that uses the same
			// data format. Export the font data as an XML file, and the texture as a png with
			// white (!) characters on a transparent background (32 bit).
			//
			// Then, you just have to register the font at the TextField class.
			// Look at the file "Assets.as" to see how this is done.
			// After that, you can use them just like a conventional TrueType font.

			var bmpFontTF : TextField = new TextField( 300 , 150 , R.string.text_bitmap );
			bmpFontTF.format.font = "Desyrel";
			bmpFontTF.format.size = BitmapFont.NATIVE_SIZE; // native bitmap font size, no scaling
			bmpFontTF.format.color = Color.WHITE; // white will draw the texture as is (no tinting)
			bmpFontTF.x = offset;
			bmpFontTF.y = fontTF.y + fontTF.height + offset;
			_content.addChild( bmpFontTF );

			// A tip: you can also add the font-texture to your standard texture atlas!
		}
	}
}