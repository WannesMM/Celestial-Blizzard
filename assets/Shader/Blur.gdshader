shader_type canvas_item;

uniform float blur_strength : hint_range(0.0, 10.0) = 2.0;
uniform sampler2D screen_texture;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec4 color = vec4(0.0);

    float total = 0.0;
    float offset = 1.0 / 300.0; // Adjust for screen size

    for (float x = -2.0; x <= 2.0; x++) {
        for (float y = -2.0; y <= 2.0; y++) {
            vec2 sample_uv = uv + vec2(x, y) * offset * blur_strength;
            color += texture(screen_texture, sample_uv);
            total += 1.0;
        }
    }
    color /= total;
    COLOR = color;
}
