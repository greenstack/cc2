function Math.clamp(number, lower, upper)
  if lower > upper then lower, upper = upper, lower end
  return math.max(math.min(upper, number), lower)
end
