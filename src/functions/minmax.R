minmax = function(values, ease = 0){
  curmin = min(values) * (1 - ease)
  curmax = max(values) * (1 + ease)
  return(c(curmin, curmax))
}