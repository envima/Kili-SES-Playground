mapvalid = function(rastlayer, minmax){
  rastlayer[rastlayer == 0] = NA
  rastlayer[!(rastlayer >= minmax[1] & rastlayer <= minmax[2])] = NA
  return(rastlayer)
}