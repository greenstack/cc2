extern int octaves = 1;
extern vec2 speed = vec2(0.0, 2.0);
extern float time;
extern vec2 player_position;
extern float fog_distance;
extern float fog_distance_min;

float rand(vec2 coord)
{
  return fract(sin(dot(coord, vec2(56, 78)) * 1000.0) * 1000.0);
}

float noise(vec2 coord)
{
  vec2 i = floor(coord); //get the whole number
  vec2 f = fract(coord); //get the fraction number
  float a = rand(i); //top-left
  float b = rand(i + vec2(1.0, 0.0)); //top-right
  float c = rand(i + vec2(0.0, 1.0)); //bottom-left
  float d = rand(i + vec2(1.0, 1.0)); //bottom-right
  vec2 cubic = f * f * (3.0 - 2.0 * f);
  return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y; //interpolate
}

float fbm(vec2 coord) //fractal brownian motion
{
  float value = 0.0;
  float scale = 0.5;
  for (int i = 0; i < octaves; i++)
  {
    value += noise(coord) * scale;
    coord *= 2.0;
   scale *= 0.5;
  }
  return value;
}

float distance(vec2 player, vec2 frag)
{
  return sqrt((pow(frag[1] - player[1], 2) + pow(frag[0] - player[0], 2)));
}

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 sc)
{
  vec2 motion = vec2(fbm(sc + vec2(time * speed.x, time * speed.y)));
  float final = fbm(sc + motion);

  float dist = distance(player_position, sc);
  vec4 max_fog_color = vec4(.8,.8,.8,max(.9 * final + .3, .6));
  vec4 min_fog_color = vec4(.1,.1,.1,.2);

  if(dist > fog_distance)
  {
    return max_fog_color;
  }

  if(dist > fog_distance_min)
  {
    return mix(min_fog_color, max_fog_color, (dist - fog_distance_min)/(fog_distance - fog_distance_min));
  }
  return min_fog_color;
}
