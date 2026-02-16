shader_type canvas_item;
render_mode unshaded;

uniform sampler2D source_texture: repeat_enable, source_color;
uniform vec2 scroll;

void fragment() {
	vec4 tex = texture(source_texture, UV + scroll * TIME);
	COLOR.rgb = tex.rgb * tex.a;
	COLOR.a = tex.a * COLOR.a;
}
