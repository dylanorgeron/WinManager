;load positions
global windowPositions =
IniRead, windowPositions, positions.ini, WindowPositions

;reading positions
getX(position){
  RegExMatch(windowPositions, "Position" . position . "=([^,]*)", match)
  return %match1%
}
getY(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,([^,]*)", match)
  return %match1%
}
getW(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,[^,]*,([^,]*)", match)
  return %match1%
}
getH(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,[^,]*,[^,]*,([^,]*)\s", match)
  return %match1%
}

;writing positions
writePositionCoords(position, x, y, w, h){
  IniWrite, %x%`,%y%`,%w%`,%h%, positions.ini, WindowPositions, Position%position%
  return
}