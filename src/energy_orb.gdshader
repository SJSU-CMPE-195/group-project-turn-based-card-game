shader_type canvas_item;
uniform vec2 scroll;
uniform sampler2D falloff_tex; 
uniform sampler2D gradient;
uniform sampler2D noise_tex: repeat_enable;

void vertex() {
	
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 falloff = texture(falloff_tex, UV);
	float noise = texture(noise_tex, cos(UV) + TIME * scroll).r;
	vec3 gradient_color = texture(gradient, vec2(falloff.r + noise * 0.15, 0.0)).rgb;
	COLOR.rgb = gradient_color;
	float dist = (1.0 - distance(vec2(0.5, 0.5), UV) * 2.6);
	COLOR.a = falloff.a + 3.0 * noise * dist;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
