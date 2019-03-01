#define PI 3.141592
#define RECT_COUNT 256

uniform vec2 playerPos;
uniform vec2 translate;
uniform vec4[RECT_COUNT] rects;

struct Line {
    vec2 p1;
    vec2 p2;
};

bool LineIntersectsLine(Line l1, Line l2) {
    number q = (l1.p1.y - l2.p1.y) * (l2.p2.x - l2.p1.x) - (l1.p1.x - l2.p1.x) * (l2.p2.y - l2.p1.y);
    number d = (l1.p2.x - l1.p1.x) * (l2.p2.y - l2.p1.y) - (l1.p2.y - l1.p1.y) * (l2.p2.x - l2.p1.x);

    if (d == 0) return false;

    number r = q / d;
    q = (l1.p1.y - l2.p1.y) * (l1.p2.x - l1.p1.x) - (l1.p1.x - l2.p1.x) * (l1.p2.y - l1.p1.y);
    number s = q / d;

    if (r < 0 || r > 1 || s < 0 || s > 1)
        return false;

    return true;
}

bool LineIntersectsRect(Line l, vec4 rect) {
    vec2 bottomRight = rect.xy + rect.zw;
    vec2 topRight = vec2(rect.x + rect.z, rect.y);
    vec2 topLeft = rect.xy;
    vec2 bottomLeft = vec2(rect.x, rect.y + rect.w);
    return LineIntersectsLine(l, Line(topLeft, topRight)) ||
        LineIntersectsLine(l, Line(topLeft, bottomLeft)) ||
        LineIntersectsLine(l, Line(bottomLeft, bottomRight)) ||
        LineIntersectsLine(l, Line(topRight, bottomRight));
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    Line toPlayer = Line(screen_coords, playerPos);
    float transp = 1;
    mat4 translation;
    translation[0][0] = 1;
    translation[1][1] = 1;
    translation[2][2] = 1;
    translation[3][3] = 1;
    translation[0][3] = translate.x;
    translation[1][3] = translate.y;
    for (int i = 0; i < RECT_COUNT; ++i)
        if (LineIntersectsRect(toPlayer, rects[i] * translation)) {
            transp = 0;
            break;
        }

    return transp * color * Texel(texture, texture_coords);
}
