#define PI 3.141592
#define RECT_COUNT _HITBOX_TOTAL_

uniform vec2 playerPos;
uniform vec2 translate;
uniform vec4[RECT_COUNT] rects;

bool LineIntersectsLine(vec4 l1, vec4 l2) {
    number q = (l1.y - l2.y) * (l2.z - l2.x) - (l1.x - l2.x) * (l2.w - l2.y);
    number d = (l1.z - l1.x) * (l2.w - l2.y) - (l1.w - l1.y) * (l2.z - l2.x);

    if (d == 0) return false;

    number r = q / d;
    q = (l1.y - l2.y) * (l1.z - l1.x) - (l1.x - l2.x) * (l1.w - l1.y);
    number s = q / d;

    if (r < 0 || r > 1 || s < 0 || s > 1)
        return false;

    return true;
}

bool LineIntersectsRect(vec4 l, vec4 rect) {
    vec2 bottomRight = rect.xy + rect.zw;
    vec2 topRight = vec2(rect.x + rect.z, rect.y);
    vec2 topLeft = rect.xy;
    vec2 bottomLeft = vec2(rect.x, rect.y + rect.w);
    return LineIntersectsLine(l, vec4(topLeft, topRight)) ||
        LineIntersectsLine(l, vec4(topLeft, bottomLeft)) ||
        LineIntersectsLine(l, vec4(bottomLeft, bottomRight)) ||
        LineIntersectsLine(l, vec4(topRight, bottomRight));
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 toPlayer = vec4(screen_coords, playerPos);
    float dist = length(screen_coords - playerPos);
    
    for (int i = 0; i < RECT_COUNT; ++i) {
        vec4 tempRect = rects[i];
        tempRect.xy += translate;
        if (LineIntersectsRect(toPlayer, tempRect))
            return vec4(.1, .1, .1, .5);
    }
    int fade_start = 200;
    if(dist > fade_start) {
      float fade = min(1,(dist - fade_start) / 200);
      return vec4(.1, .1, .1, .5*fade);
    }

    return vec4(0,0,0,0);
}
