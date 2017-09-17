# Fallout 4 Scopes
A Fallout 4 framework for loading custom scopes and optics.

**Videos**: https://www.youtube.com/playlist?list=PLdEgiq4kaju3CYBlhULuza2JnbikUS18Q

**Resources**: https://github.com/Scrivener07/FO4_Interface `FO4_1599712_1.9.4.0_Release_EN` `df2c1c6`


#### Features
* Framework allows all new scope and optic crosshairs for weapons. 
* Easily create custom content. No data plugins, no scripts!
* Optional advanced API for overlays to interact with Papyrus scripting.
* "it just works" 😉


#### Installation
* Install with your preferred mod manager, or copy the files into your Fallout 4 data directory.
* Activate `Scopes.esp` anywhere within your load order.


#### Requirements
* Requires a computer, PC only.
* Requires the latest version of F4SE.


#### Acknowledgements
Thanks to the F4SE team for their continued efforts to make mods like this possible.


# Custom Content
This section is for modders who would like to create a custom scope overlay.

The process is simple.
Create a vector based image such as `.svg` or `.ai` for your scope overlay.
Then import your vector image into new flash file (`.fla`), publish the `.swf` to a directory that matches a valid weapon scope object modification. Thats it!


## Notes
With this system a single physical (`.nif`) representation of a scope is paired with a single visual (`.swf`) representation of a scope. A unquie resource identifier for the `.swf` file path is derived from the omod's world model path.
Your scope omod must also add the `HasScope` keyword to a weapon via its property modifiers.
If your scope omod model is `Meshes\Weapons\44\44Scope.nif` then your scope overlay will be autoloaded from `Interface\Weapons\44\44Scope.swf`. 

* Adobe Illustrator
* * Illustrator requires RGB color mode.
* Adobe Flash (Adobe Animate)
* * Document dimensions must be `1280x720` in size.
* * Overlay must be centered on the stage.
