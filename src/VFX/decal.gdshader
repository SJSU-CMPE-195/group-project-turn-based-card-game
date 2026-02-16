shader_type canvas_item;

uniform sampler2D decal_texture: source_color;

void fragment() {
	vec4 tex = texture(decal_texture, UV);
	COLOR.rgb *= tex.rgb;
	COLOR.a = tex.a * COLOR.a;
	// Called for every pixel the material is visible on.
}

