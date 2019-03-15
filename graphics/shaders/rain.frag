vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    return color * Texel(texture, texture_coords) + vec4(-0.1, -0.1, 0.1, 0);
}
