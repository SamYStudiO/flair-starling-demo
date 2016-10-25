package
{
	/**
	 * DO NOT edit this class, this is auto generated from your resources directories.
	 * This class try to mimic android R class but will return resource instances instead of resource ids.
	 * For example :
	 * var image : Image = new Image( R.drawable.drawable_id );
	 * var text : String = R.string.string_id;
	 * var soundChannel : SoundChannel = R.sound.sound_id.play();
	 */
	public final class R
	{
		public static var bool : RBool;
		public static var color : RColor;
		public static var dimen : RDimen;
		public static var drawable : RDrawable;
		public static var integer : RInteger;
		public static var object : RObject;
		public static var raw : RRaw;
		public static var sound : RSound;
		public static var string : RString;
		public static var xml : RXml;

		public function R( singleton : Singleton )
		{
			bool = new RBool();
			color = new RColor();
			dimen = new RDimen();
			drawable = new RDrawable();
			integer = new RInteger();
			object = new RObject();
			raw = new RRaw();
			sound = new RSound();
			string = new RString();
			xml = new RXml();
		}
	}
}

import flair.resources.*;
import flash.media.Sound;
import flash.utils.ByteArray;
import starling.textures.Texture;

new R( new Singleton() );

class Singleton
{

}

class RBool
{
}

class RColor
{
}

class RDimen
{
	public const screen_padding : Number = getDimen( "screen_padding" );
	public const button_padding_left_right : Number = getDimen( "button_padding_left_right" );
	public const button_padding_top_button : Number = getDimen( "button_padding_top_button" );
	public const gap : Number = getDimen( "gap" );
}

class RDrawable
{
	public const benchmark_object : Texture = getDrawable( "benchmark_object" );
	public const brush : Texture = getDrawable( "brush" );
	public const button : Texture = getDrawable( "button" );
	public const flight_00 : Texture = getDrawable( "flight_00" );
	public const flight_01 : Texture = getDrawable( "flight_01" );
	public const flight_02 : Texture = getDrawable( "flight_02" );
	public const flight_03 : Texture = getDrawable( "flight_03" );
	public const flight_04 : Texture = getDrawable( "flight_04" );
	public const flight_05 : Texture = getDrawable( "flight_05" );
	public const flight_06 : Texture = getDrawable( "flight_06" );
	public const flight_07 : Texture = getDrawable( "flight_07" );
	public const flight_08 : Texture = getDrawable( "flight_08" );
	public const flight_09 : Texture = getDrawable( "flight_09" );
	public const flight_10 : Texture = getDrawable( "flight_10" );
	public const flight_11 : Texture = getDrawable( "flight_11" );
	public const flight_12 : Texture = getDrawable( "flight_12" );
	public const flight_13 : Texture = getDrawable( "flight_13" );
	public const gamua_logo : Texture = getDrawable( "gamua-logo" );
	public const logo : Texture = getDrawable( "logo" );
	public const starling_front : Texture = getDrawable( "starling_front" );
	public const starling_rocket : Texture = getDrawable( "starling_rocket" );
	public const starling_round : Texture = getDrawable( "starling_round" );
	public const starling_sheet : Texture = getDrawable( "starling_sheet" );
	public const background : Texture = getDrawable( "background" );
	public const compressed_texture : Texture = getDrawable( "compressed_texture" );
	public const desyrel : Texture = getDrawable( "desyrel" );
}

class RInteger
{
}

class RObject
{
}

class RRaw
{
}

class RSound
{
	public const wing_flap : Sound = getSound( "wing_flap" );
}

class RString
{
	public const root_screen : String = getString( "root_screen" );
	public const animation : String = getString( "animation" );
	public const benchmark : String = getString( "benchmark" );
	public const blendMode : String = getString( "blendMode" );
	public const customHitTest : String = getString( "customHitTest" );
	public const filter : String = getString( "filter" );
	public const mask : String = getString( "mask" );
	public const movie : String = getString( "movie" );
	public const renderTexture : String = getString( "renderTexture" );
	public const sprite3d : String = getString( "sprite3d" );
	public const text : String = getString( "text" );
	public const texture : String = getString( "texture" );
	public const touch : String = getString( "touch" );
	public const back : String = getString( "back" );
	public const start_benchmark : String = getString( "start_benchmark" );
	public const benchmark_object_count : String = getString( "benchmark_object_count" );
	public const benchmark_result : String = getString( "benchmark_result" );
	public const blend_mode_switch_mode : String = getString( "blend_mode_switch_mode" );
	public const custom_hit_description : String = getString( "custom_hit_description" );
	public const filter_switch : String = getString( "filter_switch" );
	public const filter_identity : String = getString( "filter_identity" );
	public const filter_blur : String = getString( "filter_blur" );
	public const filter_shadow : String = getString( "filter_shadow" );
	public const filter_glow : String = getString( "filter_glow" );
	public const filter_displacement : String = getString( "filter_displacement" );
	public const filter_invert : String = getString( "filter_invert" );
	public const filter_gray_scale : String = getString( "filter_gray_scale" );
	public const filter_saturation : String = getString( "filter_saturation" );
	public const filter_contrast : String = getString( "filter_contrast" );
	public const filter_brightness : String = getString( "filter_brightness" );
	public const filter_hue : String = getString( "filter_hue" );
	public const filter_hue_shadow : String = getString( "filter_hue_shadow" );
	public const mask_help : String = getString( "mask_help" );
	public const render_texture_help : String = getString( "render_texture_help" );
	public const render_texture_draw : String = getString( "render_texture_draw" );
	public const render_texture_erase : String = getString( "render_texture_erase" );
	public const text_border_color : String = getString( "text_border_color" );
	public const text_top_left : String = getString( "text_top_left" );
	public const text_bottom_right : String = getString( "text_bottom_right" );
	public const text_centered : String = getString( "text_centered" );
	public const text_bitmap : String = getString( "text_bitmap" );
	public const touch_help : String = getString( "touch_help" );
}

class RXml
{
}