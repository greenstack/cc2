#define PI 3.141592
// This _HITBOX_TOTAL_ should be replaced by the actual amonth of hitboxes in
// the current level when the shader is loaded in. This will ensure that the
// correct amount of VRAM is allocated for the hitboxes.
#define RECT_COUNT _HITBOX_TOTAL_

// 7:30 pm is 70200. Reduce range of sight until 9:00 pm (75600)
// reduce range (fade) to 50

// 9:30 am is 34200. Raise range of sight until 11:00 am (39600)
// start at 150, go up to 300
uniform vec2 playerPos;
uniform vec2 translate;
uniform vec4[RECT_COUNT] rects;

uniform float morning_fade; // range in the morning
uniform float fade;         // Standard daytime fade distance. Default is 300
uniform float evening_fade; // minimum range in the morning
uniform float worldTime;      // Current time in the world.
uniform vec2 morningBounds; // the time after which to increase range and the time
                            // to stop increasing
uniform vec2 eveningBounds; // the time after which to decrease range and the time
                            // to stop decreasing 

uniform float shadowAlpha; 

float shadowGray = 0.1;

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

    if (rect.x <= l.x && l.x <= rect.x + rect.z &&
        rect.y <= l.y && l.y <= rect.y + rect.w ||
        rect.x <= l.z && l.z <= rect.x + rect.z &&
        rect.y <= l.w && l.w <= rect.y + rect.w)
        return 1;

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

bool betweenInclusive(float lower, float n, float upper) {
    return (lower <= n && n <= upper);
}

float getFadeDistance(float fade_to, float fade_from, vec2 bounds) {
    float slope = (fade_to - fade_from) / (bounds.y - bounds.x);
    float intercept = fade_to - bounds.y * slope;
    return slope * worldTime + intercept;
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
            return vec4(vec3(shadowGray), shadowAlpha);
        if (0 < intersections && intersections <= 1) {
            return vec4(vec3(shadowGray), shadowAlpha/2);
        }
    }

    float fade_dist = fade;
    if (worldTime <= morningBounds.x) {
        fade_dist = morning_fade;
    }
    else if (betweenInclusive(morningBounds.x, worldTime, morningBounds.y)) {
        fade_dist = getFadeDistance(fade, morning_fade, morningBounds);
    }
    else if (betweenInclusive(morningBounds.y, worldTime, eveningBounds.x)) {
        fade_dist = fade;
    }
    else if (betweenInclusive(eveningBounds.x, worldTime, eveningBounds.y)) {
        fade_dist = getFadeDistance(evening_fade, fade, eveningBounds);
    }
    else if (worldTime >= eveningBounds.y) {
        fade_dist = evening_fade;
    }
    else fade_dist = 0;

    float shadowMod = 0;
    /*if (betweenInclusive(morningBounds.y, worldTime, eveningBounds.x)) {
        // make the shadows lighter
        shadowMod = -shadowAlpha*(1/(eveningBounds.x - morningBounds.y)*worldTime);
    }*/
    shadowMod += shadowAlpha;
    if(dist > fade_dist) {
      float fade_mag = min(1,(dist - fade_dist) / 200);
      return vec4(vec3(shadowGray), shadowMod * fade_mag);
    }

    return vec4(0,0,0,0);
}
