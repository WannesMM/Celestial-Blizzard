shader_type canvas_item;

uniform float time_speed = 3.0;  // Speed of flicker
uniform float flicker_intensity = 0.5; // Strength of flicker
uniform vec4 color1 = vec4(1.0, 0.2, 0.2, 1.0); // Red color
uniform vec4 color2 = vec4(1.0, 1.0, 0.2, 1.0); // Yellow color

void fragment() {
    vec2 uv = UV;

    // Time-based flickering (randomized intensity)
    float flicker = step(flicker_intensity, fract(sin(dot(uv, vec2(12.9898,78.233))) * 43758.5453 + TIME * time_speed));

    // Horizontal distortion effect
    float offset = sin(TIME * 10.0 + uv.y * 5.0) * 0.02;

    // Mix colors based on flicker effect
    vec4 final_color = mix(color1, color2, flicker);

    // Apply distortion effect
    vec4 tex_color = texture(TEXTURE, vec2(uv.x + offset, uv.y));

    // Output final color, keeping transparency
    COLOR = tex_color * final_color;
}
