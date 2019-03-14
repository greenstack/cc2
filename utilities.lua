function clamp(number, lower, upper)
  if lower > upper then lower, upper = upper, lower end
  return math.max(math.min(upper, number), lower)
end

function table.contains(t,el) 
  for _,v in pairs(t) do
    if v == el then
      return true
    end
  end
  return false
end