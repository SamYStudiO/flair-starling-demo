#flair-starling-demo
This is a demo project for [flair-gradle-plugin](https://github.com/SamYStudiO/flair-gradle-plugin) using [Starling](https://github.com/Gamua/Starling-Framework) original [demo](http://gamua.com/starling/demo/).
Starling demo sources have also been modify to include [Feathers](https://github.com/BowlerHatLLC/feathers) Screen navigation (and layout) since Flair relies on Feathers Screen to manage resources.

===
#####GETTING STARTED
After you checked out project from IntelliJ, you need to initialize gradle.
Open gradle panel on the right ![gradle](https://raw.githubusercontent.com/wiki/SamYStudiO/flair-gradle-plugin/images/gradle_panel.png) and click refresh button ![gradle](https://raw.githubusercontent.com/wiki/SamYStudiO/flair-gradle-plugin/images/gradle_refresh.png).

An error should be display at the bottom *Error:Cannot find AIR SDK home, set a valid AIR SDK home from your local.properties file under project root*. You need to set your AIR SDK path from local.properties file just created in your project tree on the left (if you can't see that file created at your project root try refreshing your project tree ![gradle](https://raw.githubusercontent.com/wiki/SamYStudiO/flair-gradle-plugin/images/project_refresh.png)).

After setting your AIR SDK path refresh gradle again from gradle panel an that's it!

You can run project using gradle task from gradle panel under *launch* directory or even use IntelliJ run configuration generated by Flair plugin. 

![gradle](https://raw.githubusercontent.com/wiki/SamYStudiO/flair-gradle-plugin/images/launch_configuration.png)

For a complete Flair guide check its [wiki](https://github.com/SamYStudiO/flair-gradle-plugin/wiki).

