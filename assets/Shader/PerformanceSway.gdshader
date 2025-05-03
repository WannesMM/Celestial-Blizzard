shader_type spatial;
render_mode unshaded, cull_back;

uniform sampler2D albedo_texture : source_color;
uniform float wind_strength : hint_range(0.0, 1.0) = 0.2;
uniform float wind_speed : hint_range(0.0, 5.0) = 1.0;
uniform float alpha_cutoff : hint_range(0.0, 1.0) = 0.5;

void vertex() {
    float scale = INSTANCE_CUSTOM.x;
    float sway_offset = INSTANCE_CUSTOM.y;

    VERTEX *= vec3(scale); // Scale before sway

    float sway = sin(UV.y * 5.0 + TIME * wind_speed + sway_offset) * (1.0 - UV.y) * wind_strength;
    VERTEX.x += sway;
}

void fragment() {
    vec4 tex = texture(albedo_texture, UV);
    ALBEDO = tex.rgb;
    ALPHA = tex.a;
    ALPHA_SCISSOR_THRESHOLD = alpha_cutoff;
}
