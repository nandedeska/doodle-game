shader_type canvas_item;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR = pixelColor + vec4(0.5,0.5,0.5,0);
}
