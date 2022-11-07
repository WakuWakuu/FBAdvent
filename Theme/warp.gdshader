shader_type canvas_item;

//I'm storing these as uniforms just in case I reuse this effect several times
uniform float X_movement = 80.0;
uniform float Y_movement = 10.0;
uniform float distort_effect = 0.0;

void fragment(){
	
	//Adds a distortion effect
	vec2 distort = SCREEN_UV + texture(TEXTURE, UV).a * distort_effect;
	vec4 distortTex = texture(SCREEN_TEXTURE, distort);
	COLOR = distortTex;
}

void vertex(){
	
	//Moves the texture in a circle
	VERTEX += vec2(cos(TIME)*X_movement, sin(TIME)*Y_movement);
	
}