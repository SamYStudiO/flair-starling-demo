package flair.utils.device
{
	/**
	 *
	 */
	public function isMobile() : Boolean
	{
		return isAndroid() || isIOS();
	}
}
