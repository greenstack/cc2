#define PI 3.141592
#define RECT_COUNT _HITBOX_TOTAL_

uniform vec2 playerPos;
uniform vec2 translate;
uniform vec4[RECT_COUNT] rects;
uniform float fade;

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

vec2 GetIntersectionPoint(vec4 a, vec4 b) {
    return vec2(0,0);
}

float LineIntersectsRect(vec4 l, vec4 rect) {
    vec2 bottomRight = rect.xy + rect.zw;
    vec2 topRight = vec2(rect.x + rect.z, rect.y);
    vec2 topLeft = rect.xy;
    vec2 bottomLeft = vec2(rect.x, rect.y + rect.w);

    float intersections = 0;
    vec4 intersected, check;
    check = vec4(topLeft, topRight);
    if (LineIntersectsLine(l, check)){
        ++intersections;
        intersected = check;
    }
    check = vec4(topLeft, bottomLeft);
    if (LineIntersectsLine(l, check)) {
        ++intersections;
        intersected = check;
    }
    check = vec4(bottomLeft, bottomRight);
    if (intersections < 2 && LineIntersectsLine(l, check)) {
        ++intersections;
        intersected = check;
    }
    check = vec4(topRight, bottomRight);
    if (intersections < 2 && LineIntersectsLine(l, check)) {
        ++intersections;
        intersected = check;
    }
    if (intersections == 1) {
        vec2 intPt = GetIntersectionPoint(l, intersected);
        
    }
    return intersections;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 toPlayer = vec4(screen_coords, playerPos);
    float dist = length(screen_coords - playerPos);
    float intersections = 0;
    for (int i = 0; i < RECT_COUNT; ++i) {
        vec4 tempRect = rects[i];
        tempRect.xy += translate;
        intersections += LineIntersectsRect(toPlayer, tempRect);
        if (intersections > 1)
            return vec4(.1, .1, .1, .5);
        if (0 < intersections && intersections <= 1) {
            return vec4(.1, .1, .1, .25);
        }
    }

    if(dist > fade) {
      float fade_mag = min(1,(dist - fade) / 200);
      return vec4(.1, .1, .1, .5*fade_mag);
    }

    return vec4(0,0,0,0);
}
