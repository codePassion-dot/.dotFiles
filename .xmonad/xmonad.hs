import           XMonad

import           XMonad.Layout.Magnifier
import           XMonad.Layout.ThreeColumns
import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab

baseLayout = tiled ||| Mirror tiled ||| Full
 where
  threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
  tiled    = Tall nmaster delta ratio
  nmaster  = 1 -- Default number of windows in the master pane
  ratio    = 1 / 2 -- Default proportion of screen occupied by master pane
  delta    = 3 / 100 -- Percent of screen to increment by when resizing panes

main :: IO ()
main =
  xmonad $ def { modMask = mod4Mask, -- Rebind Mod to the Super key
                                     layoutHook = baseLayout } -- Use custom layouts 
