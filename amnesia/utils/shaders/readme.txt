Amnesia The Dark Descent - New Shader Creation

The way textures are stored and handled in Amnesia has changed.
Textures now use standard OpenGL GL_TEXTURE_2D textures, instead 
of the GL_TEXTURE_RECTANGLE from the NV_texture_rectangle or 
ARB_texture_rectangle extensions. 

Tex2D can handle non-power-of-two textures now (not possible when
the engine was written), so Amnesia has been changed throughout
to use them. This has a knock-on effect on the GLSL shaders, since 
Rect textures use texel/pixel coordinates to index the location
within them, whereas 2D textures used normalized texture coords 
(i.e. 0.0 to 1.0). So all shaders that used Rect texture samplers 
were changed. 

The patch files here can be used to create the updated shaders.
From your Amnesia The Dark Descent folder:
- Copy all glsl files from Amnesia/core/shaders into core.
- Copy all glsl files from Amnesia/shaders into game.

Start bash in a command prompt and navigate to this directory.
Run create_tex2d.sh. It will create new glsl files in each dir.
Copy the glsl files back to their corresponding game directories.

