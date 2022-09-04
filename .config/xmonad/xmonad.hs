import XMonad

import XMonad.Hooks.SetWMName   -- set custom window manager name (ie LG3D) for java applications (ie IntelliJ)
import XMonad.Config.Azerty     -- azerty keyboard support for switching Workspaces
import XMonad.Hooks.Place       -- automatic placement of floating windows

-- Status bar
import XMonad.Hooks.ManageDocks -- make xmonad spare a space for the status bar
import XMonad.Hooks.DynamicLog  -- give System information to the status bar
-- use dbus to send infos to status bar
-- used by xfce panel applet https://github.com/alexkay/xmonad-log-applet
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

--
import XMonad.Config.Xfce       -- uses the XFCE base configuration
import XMonad.Hooks.EwmhDesktops as EWMH
import XMonad.Hooks.ManageHelpers

import qualified Data.Map as M  -- default keybindings
import qualified XMonad.StackSet as W

import XMonad.Actions.GridSelect -- Displays a grid of open windows (~ exposé)

floatingClasses =
  [ "MPlayer"
  , "Gimp"
  , "Unity"
  , "Screenruler"
  , "Wrapper"
  , "Xfce4-xkb-plugin"
  , "Xfce4-appfinder"
  ]

-- Note : to get the className of an app : launch app, then "xprop | grep WM_CLASS"

myManageHook = composeAll [
  isFullscreen --> doFullFloat -- workaround firefox fullscreen bug (cf. https://www.reddit.com/r/xmonad/comments/4cnjhi/fullscreen_video_in_firefox/)
  ,className =? "Gvim" --> doShift "1:dev"
  ,className =? "jetbrains-idea" --> doShift "1:dev"

  ,className =? "Firefox" --> doShift "2:web"
  ,className =? "Chromium-browser" --> doShift  "2:web"

  -- ,className =? "Xfce4-terminal" --> doShift "3:shell"

  ,className =? "Mail" --> doShift "3:mail"
  ,className =? "Thunderbird" --> doShift "3:mail"
  ,resource =? "thunderbird" --> doShift  "3:mail"

  ]

main = do
  dbus <- D.connectSession
  getWellKnownName dbus
  -- spawn $ "feh --bg-scale " ++ "~/Images/Wallpapers/lapins_figaro.jpg" --Set wallpaper
  xmonad xfceConfig
    {
      workspaces = ["1:dev", "2:web", "3:mail", "4", "5:multimedia", "6", "7", "8", "9", "0:stash"]
    , keys = azertyKeys <+> myKeys
    , modMask            = mod4Mask -- use Window key as "mod" key
    , terminal           = "alacritty"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , normalBorderColor  = "#dddddd"
    , focusedBorderColor = "black"
    , manageHook         = placeHook simpleSmart <+> myManageHook <+> manageHook xfceConfig <+> manageDocks <+> (composeAll . map (\n -> className =? n --> doFloat)) floatingClasses
    , layoutHook         = avoidStruts $ layoutHook xfceConfig
    , handleEventHook    = handleEventHook xfceConfig <+> EWMH.ewmhDesktopsEventHook <+> fullscreenEventHook
    , startupHook        = EWMH.ewmhDesktopsStartup <+> setWMName "LG3D"     -- java applications support
    , logHook            =  dynamicLogWithPP (prettyPrinter dbus) -- send infos to the xfce panel applet via dbus
    -- , logHook            = EWMH.ewmhDesktopsLogHook >> dynamicLogWithPP (prettyPrinter dbus) -- give ewmh hints to xprop >> send infos to the xfce panel applet via dbus
    }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm,               xK_b     ), sendMessage ToggleStruts) -- Toggle status bar gap
    , ((modm .|. shiftMask, xK_F4    ), spawn "xfce4-session-logout") -- Log out
    , ((modm .|. shiftMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Change configuration
    --, ((modm .|. shiftMask, xK_Return), spawn "xfce4-terminal") -- launch a terminal
    , ((modm .|. shiftMask, xK_Return), spawn "termite") -- launch a terminal
    , ((modm,               xK_p     ), spawn "xfce4-appfinder") -- launch appfinder
    , ((modm,               xK_o     ), spawn "nautilus") -- launch file explorer
    , ((modm .|. shiftMask, xK_c     ), kill) -- close focused window
    , ((mod1Mask,           xK_F4    ), kill) -- ALT + F4 close focused window
    , ((modm,               xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
    , ((modm,               xK_n     ), refresh) -- Resize viewed windows to the correct size
    , ((modm,               xK_Tab   ), windows W.focusDown) -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown) -- Move focus to the next window - ALT + TAB
    , ((modm,               xK_j     ), windows W.focusDown) -- Move focus to the next window
    , ((modm,               xK_k     ), windows W.focusUp  ) -- Move focus to the previous window
    , ((modm,               xK_m     ), windows W.focusMaster  ) -- Move focus to the master window
    , ((modm,               xK_Return), windows W.swapMaster) -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Swap the focused window with the previous window
    , ((modm,               xK_h     ), sendMessage Shrink) -- Shrink the master area
    , ((modm,               xK_l     ), sendMessage Expand) -- Expand the master area
    , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    , ((modm, xK_g), goToSelected defaultGSConfig)
    ]
    --
    -- mod-[1..9], Switch to workspace
    -- mod-shift-[1..9], Move client to workspace N
    -- --
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    -- mod-{a,z,e} (underneath 1,2,3), Switch to physical/Xinerama screens 1, 2 or 3
    -- mod-shift-{a,z,e}, Move client to screen 1, 2, or 3
    -- reordered
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_z, xK_a, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

prettyPrinter :: D.Client -> PP
prettyPrinter dbus = defaultPP
    { ppOutput   = dbusOutput dbus
    , ppTitle    = pangoSanitize
    , ppCurrent  = pangoColor "white" . wrap "[" "]" . pangoSanitize
    , ppVisible  = pangoColor "gray" . wrap "(" ")" . pangoSanitize
    , ppHidden   = const ""
    , ppUrgent   = pangoColor "red"
    , ppLayout   = const ""
    , ppSep      = " "
    }

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
  D.requestName dbus (D.busName_ "org.xmonad.Log")
                [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  return ()

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal (D.objectPath_ "/org/xmonad/Log") (D.interfaceName_ "org.xmonad.Log") (D.memberName_ "Update")) {
            D.signalBody = [D.toVariant ("<b>" ++ UTF8.decodeString str ++ "</b>")]
        }
    D.emit dbus signal

pangoColor :: String -> String -> String
pangoColor fg = wrap left right
  where
    left  = "<span foreground=\"" ++ fg ++ "\">"
    right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
  where
    sanitize '>'  xs = "&gt;" ++ xs
    sanitize '<'  xs = "&lt;" ++ xs
    sanitize '\"' xs = "&quot;" ++ xs
    sanitize '&'  xs = "&amp;" ++ xs
    sanitize x xs = x:xs
