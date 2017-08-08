#Include windowTileSettings.ahk

;tile functions
tileToPos(position){
  WinMove, A,, % getX(position), % getY(position), % getW(position), % getH(position)
  return
}

setKey(keyPos){
  RegExMatch(savedHotkeys, keyPos . "=([^\d]*)", match)
  ;get length of match
  StringLen, matchLen, match1
  ;trim last char off
  matchLen -= 1
  StringLeft, trimmedStr, match1, %matchLen%
  return %trimmedStr%
}

;i dont know a better way of dynamically creating these
;ill add more later if needed
key1 = % setKey(1)
key2 = % setKey(2)
key3 = % setKey(3)

HotKey, %key1%, tile1
return
tile1:
tileToPos(1)

HotKey, %key2%, tile2
return
tile2:
tileToPos(2)

HotKey, %key3%, tile3
return
tile3:
tileToPos(3)
