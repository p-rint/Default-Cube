shader_type spatial;

uniform vec4 color : source_color;
uniform vec4 stunColor : source_color;

uniform float val : hint_range(0.0, 1.0, 0.1);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = mix(color,stunColor, val).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
