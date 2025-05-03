shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform sampler2D albedo_tex;
uniform sampler2D mask_tex;

uniform vec2 screen_mask_scale = vec2(1.0, 1.0);
uniform vec2 screen_mask_offset = vec2(0.0, 0.0);

varying vec4 world_position;

void vertex() {
    world_position = MODEL_MATRIX * vec4(VERTEX, 1.0);
}

void fragment() {
    // Project world position into clip space
    vec4 clip_position = PROJECTION_MATRIX * VIEW_MATRIX * world_position;
    
    // Normalize to screen-space UV (0–1)
    vec2 screen_uv = (clip_position.xy / clip_position.w) * 0.5 + 0.5;
    
    // Adjust for scale/offset if needed
    screen_uv = screen_uv * screen_mask_scale + screen_mask_offset;

    // Sample albedo and mask
    vec4 tex_color = texture(albedo_tex, UV);
    float mask_val = texture(mask_tex, screen_uv).r;

    // Discard if outside the mask
    if (mask_val < 0.5) {
        discard;
    }

    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a;
}


