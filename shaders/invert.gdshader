shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 1.0, 0.01);

void fragment(){
	
	vec4 color = vec4(texture(SCREEN_TEXTURE, SCREEN_UV).rgb, texture(TEXTURE, UV).a);
	vec4 inverted = vec4(1.0 - color.rgb,  color.a);
	
	COLOR = amount * inverted + ((1.0 - amount) * color);
}