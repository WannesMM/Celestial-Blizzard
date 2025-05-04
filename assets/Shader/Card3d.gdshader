shader_type spatial;

render_mode unshaded;

uniform sampler2D albedo_texture : source_color;
uniform float corner_radius : hint_range(0.0, 0.5) = 0.1;
uniform float edge_softness : hint_range(0.0, 0.05) = 0.005;

void fragment() {
    vec2 uv = UV;
    vec4 tex_color = texture(albedo_texture, uv);

    // Rounded corner mask
    float r = corner_radius;
    vec2 dist = abs(uv - vec2(0.5)) - vec2(0.5 - r);
    float corner_dist = length(max(dist, 0.0));
    float mask = 1.0 - smoothstep(r - edge_softness, r, corner_dist);

    // Set the output color (use ALBEDO for the base color)
    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a * mask;

    if (ALPHA < 0.01) {
        discard;
    }
}


