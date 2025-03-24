shader_type canvas_item;

uniform float radius = 20.0;  // Adjust the roundness of corners
uniform vec4 color = vec4(1.0, 1.0, 1.0, 1.0);  // Rectangle color

void fragment() {
    vec2 rect_size = vec2(textureSize(SCREEN_TEXTURE, 0));  // Get screen size
    vec2 uv_pos = UV * rect_size;  // Scale UV to screen size

    float border_radius = radius;  // Set the radius for rounded corners

    // Round top-left corner
    if (uv_pos.x < border_radius && uv_pos.y < border_radius) {
        if (length(uv_pos - vec2(border_radius)) > border_radius) {
            discard;  // Remove pixels outside the rounded area
        }
    }
    // Round top-right corner
    if (uv_pos.x > rect_size.x - border_radius && uv_pos.y < border_radius) {
        if (length(uv_pos - vec2(rect_size.x - border_radius, border_radius)) > border_radius) {
            discard;
        }
    }
    // Round bottom-left corner
    if (uv_pos.x < border_radius && uv_pos.y > rect_size.y - border_radius) {
        if (length(uv_pos - vec2(border_radius, rect_size.y - border_radius)) > border_radius) {
            discard;
        }
    }
    // Round bottom-right corner
    if (uv_pos.x > rect_size.x - border_radius && uv_pos.y > rect_size.y - border_radius) {
        if (length(uv_pos - vec2(rect_size.x - border_radius, rect_size.y - border_radius)) > border_radius) {
            discard;
        }
    }

    COLOR = color;  // Apply the color to the rectangle
}
