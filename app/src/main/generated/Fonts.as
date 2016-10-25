package
{
	/**
	 * DO NOT edit this class, this is auto generated from your fonts directories.
	 * To make it work properly you need to add "Bold/Italic/Cff" explicitly in your font file name
	 * (for example arialBold.ttf, arialBoldItalicCff.ttf, verdanaCff.ttf),
	 * for better readability and class property name generation use camelCase with your font file names.
	 */
	public final class Fonts
	{		
		public static const UBUNTU : String = "Ubuntu";
		[Embed(source="/Ubuntu.ttf",fontFamily="Ubuntu",fontWeight="normal",fontStyle="normal",mimeType="application/x-font",embedAsCFF="false")]
		private static var UBUNTU_CLASS : Class;

		public function Fonts()
		{
			throw new Error( this + " cannot be instantiated" );
		}
	}
}