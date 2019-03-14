//uniform love_ScreenSize;
#define dThresh 10.0
#define highlight .15

float distance(vec2 p1, vec2 p2, vec2 p0) {
    return
        abs((p2.y-p1.y)*p0.x-(p2.x-p1.x)*p0.y+p2.x*p1.y-p2.y*p1.x)/
        sqrt(pow(p2.y-p1.y, 2) + pow(p2.x-p1.x, 2));
}

// This shader works by checking if the pixel is close to the edge of the screen.
// If it is within the threshold (defined by dThresh), it fades a bit, until the
// pixel is about 15% whiter than it was before. It does this to all pixels - each
// will be at least 15% whiter as a result of this shader.
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 topLeft = vec2(0.0, 0.0);
    vec2 topRight = vec2(love_ScreenSize.x, 0.0);
    vec2 botLeft = vec2(0.0, love_ScreenSize.y);
    vec2 botRight = love_ScreenSize.xy;
    vec4 modifier;
    float d;
    float modVar = 0;
    if ((d = distance(topLeft, topRight, screen_coords)) < dThresh)
        modVar = max(modVar, (dThresh-d)/dThresh);
    if ((d = distance(topLeft, botLeft, screen_coords)) < dThresh)
        modVar = max(modVar, (dThresh-d)/dThresh);
    if ((d = distance(botLeft, botRight, screen_coords)) < dThresh)
        modVar = max(modVar, (dThresh-d)/dThresh);
    if ((d = distance(topRight, botRight, screen_coords)) < dThresh)
        modVar = max(modVar, (dThresh-d)/dThresh);
    if (modVar < highlight)
        modVar = highlight;

    modifier = vec4(vec3(modVar), 0);
    return color * Texel(texture, texture_coords) + modifier;
}
