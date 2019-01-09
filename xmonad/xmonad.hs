import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ def
        { manageHook = manageDocks <+> manageHook def
        , layoutHook = avoidStruts  $  layoutHook def
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , startupHook = setWMName "LG3D"
        , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , normalBorderColor  = "black"     --border color
        , focusedBorderColor = "gray"    --focused border color
        , borderWidth = 1
        , terminal = "termite"
        } `additionalKeys`
        -- [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock && xset dpms force off")
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "sleep 0.2; scrot -s -e 'mv $f ~/Pictures/shots/'")
        , ((mod4Mask .|. shiftMask, xK_o), spawn "sleep 0.2; scrot -e 'mv $f ~/Pictures/shots/'")
        , ((mod4Mask,               xK_j),  nextWS)
        , ((mod4Mask,               xK_k),    prevWS)
        , ((mod4Mask .|. shiftMask, xK_j),  shiftToNext)
        , ((mod4Mask .|. shiftMask, xK_k),    shiftToPrev)
        , ((mod4Mask,               xK_Right), nextScreen)
        , ((mod4Mask,               xK_Left),  prevScreen)
        , ((mod4Mask .|. shiftMask, xK_Right), shiftNextScreen)
        , ((mod4Mask .|. shiftMask, xK_Left),  shiftPrevScreen)
        , ((mod4Mask,               xK_z),     toggleWS)
          -- XF86AudioMute
        -- , ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
        , ((0, 0x1008ff12), spawn "amixer -q set Master toggle")
          -- XF86AudioRaiseVolume
        , ((0, 0x1008ff13), spawn "amixer -M sset Master 5000+")
          -- XF86AudioLowerVolume
        , ((0, 0x1008ff11), spawn "amixer -M sset Master 5000-")
          --  XF86PlayPause
        , ((0, 0x1008ff14), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
          -- previous
        , ((0, 0x1008ff16), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
          -- next
        , ((0, 0x1008ff17), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
        , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
        ]
