shader_type canvas_item;

uniform sampler2D dissolve_texture;
uniform float dissolve_value;

void fragment() {
    vec4 main_texture = texture(TEXTURE, UV);
    vec4 noise_texture = texture(dissolve_texture, UV);

    // Apply dissolve effect
    main_texture.a *= step(noise_texture.r, dissolve_value);

    COLOR = main_texture;
}

