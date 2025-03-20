shader_type canvas_item;

void fragment() {
    vec2 uv = UV;
    uv.y += sin(uv.x * 20.0 + TIME * 5.0) * 0.05;

    vec4 tex_color = texture(TEXTURE, uv);
    COLOR = tex_color * COLOR; // Preserve the node's modulate color
}
