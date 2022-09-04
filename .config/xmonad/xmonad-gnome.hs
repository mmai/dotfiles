import XMonad

import XMonad.Hooks.SetWMName (setWMName) -- set custom window manager name (ie LG3D) for java applications (ie IntelliJ)
import XMonad.Config.Azerty     -- azerty keyboard support for switching Workspaces

import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)

import qualified Data.Map as M  -- default keybindings
import qualified XMonad.StackSet as W

import XMonad.Actions.GridSelect -- Displays a grid of open windows (~ exposé) modm + g

-- Note : to get the className of an app : launch app, then "xprop | grep WM_CLASS" et prendre la dernière valeur (la première ne fonctionne pas)

myManageHook = composeAll
  [ transience'
  , windowTypes
  , titlesAndClasses
  ]
  where windowTypes = composeOne
          [ isSplash -?> doIgnore
          , isFullscreen -?> doFullFloat
          , isDialog -?> doCenterFloat
          ]
        isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"
        titlesAndClasses = composeOne
          [ title =? "Gimp" -?> doFloat
          , title =? "Screenruler" -?> doFloat
          , title =? "Monitor" -?> doFloat
          ,className =? "Mail" -?> doShift "3:mail"
          ,className =? "Thunderbird" -?> doShift "3:mail"
          ,className =? "Firefox" -?> doShift "2:web"
          ,className =? "Google-chrome" -?> doShift "2:web"
          ]

myStartupHook = setWMName "LG3D"   -- java applications support

app_terminal = "alacritty"
-- app_terminal = "gnome-terminal"
app_launcher = "xfce4-appfinder"
app_files = "nautilus"

main =
  xmonad $ gnomeConfig
    {
      workspaces = ["1:dev", "2:web", "3:mail", "4", "5:multimedia", "6", "7", "8", "9", "0:stash"]
    , keys = azertyKeys <+> myKeys
    , modMask            = mod4Mask -- use Window key as "mod" key (default = ALT)
    , focusFollowsMouse = False
    , clickJustFocuses   = False
    , normalBorderColor  = "#dddddd"
    , focusedBorderColor = "black"
    , layoutHook = smartBorders $ layoutHook gnomeConfig
    , handleEventHook = fullscreenEventHook <+> handleEventHook gnomeConfig
    , manageHook = myManageHook <+> manageHook gnomeConfig
    , startupHook = startupHook gnomeConfig >> myStartupHook
    }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Change configuration
    -- , ((modm .|. shiftMask, xK_Return), spawn "termite") -- launch a terminal
    , ((modm .|. shiftMask, xK_Return), spawn app_terminal) -- launch a terminal
    , ((modm,               xK_p     ), spawn app_launcher) -- launch appfinder
    , ((modm,               xK_o     ), spawn app_files) -- launch file explorer
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
        | (key, sc) <- zip [xK_a, xK_z, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
