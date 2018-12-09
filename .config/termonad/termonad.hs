{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Colour.SRGB (Colour, sRGB24)
import Termonad.App (defaultMain)
import Termonad.Config
  ( FontConfig, FontSize(FontSizePoints), Option(Set)
  , ShowScrollbar(ShowScrollbarAlways), defaultConfigOptions, defaultFontConfig
  , defaultTMConfig, fontConfig, fontFamily, fontSize, options, showScrollbar
  )
import Termonad.Config.Colour
  (ColourConfig, addColourExtension, createColourExtension, cursorBgColour
  , foregroundColour, backgroundColour, palette, Palette(..), defaultColourConfig
  )
import Termonad.Config.Vec (Vec((:*), EmptyVec), N8, unsafeFromListVec_)

-- | This sets the color of the cursor in the terminal.
--
-- This uses the "Data.Colour" module to define a dark-red color.
-- There are many default colors defined in "Data.Colour.Names".
cursBgColor :: Colour Double
cursBgColor = sRGB24 204 0 0

-- | This sets the colors used for the terminal.  We only specify the background
-- color of the cursor.
colConf :: ColourConfig (Colour Double)
colConf =
  defaultColourConfig
    { cursorBgColour   = Set $ sRGB24 0xE0 0xE0 0xE0 
    , foregroundColour = sRGB24 0xD0 0xD0 0xD0  
    , backgroundColour = sRGB24 0x15 0x15 0x15
    , palette = summerFruitDark
    }

summerFruitDark :: Palette (Colour Double)
summerFruitDark = ExtendedPalette sfStandardColours sfLightColours where
  sfStandardColours :: Vec N8 (Colour Double)
  sfStandardColours = sRGB24 0x15 0x15 0x15 -- color0  = #151515
                   :* sRGB24 0xFF 0 0x86    -- color1  = #FF0086
                   :* sRGB24 0 0xC9 0x18    -- color2  = #00C918
                   :* sRGB24 0xAB 0xA8 0    -- color3  = #ABA800
                   :* sRGB24 0x37 0x77 0xE6 -- color4  = #3777E6
                   :* sRGB24 0xAD 0x00 0xA1 -- color5  = #AD00A1
                   :* sRGB24 0x1F 0xAA 0xAA -- color6  = #1FAAAA
                   :* sRGB24 0xD0 0xD0 0xD0 -- color7  = #D0D0D0
                   :* EmptyVec
  sfLightColours   :: Vec N8 (Colour Double)
  sfLightColours   = sRGB24 0x50 0x50 0x50 -- color8  = #505050
                  :* sRGB24 0xFF 0x00 0x86 -- color9  = #FF0086
                  :* sRGB24 0x00 0xC9 0x18 -- color10 = #00C918
                  :* sRGB24 0xAB 0xA8 0x00 -- color11 = #ABA800
                  :* sRGB24 0x37 0x77 0xE6 -- color12 = #3777E6
                  :* sRGB24 0xAD 0x00 0xA1 -- color13 = #AD00A1
                  :* sRGB24 0x1F 0xAA 0xAA -- color14 = #1FAAAA
                  :* sRGB24 0xFF 0xFF 0xFF -- color15 = #FFFFFF
                  :* EmptyVec
-- color16 = #FD8900
-- color17 = #CC6633
-- color18 = #202020
-- color19 = #303030
-- color20 = #B0B0B0
-- color21 = #E0E0E0
-- foreground      = #D0D0D0
-- foreground_bold = #E0E0E0
-- cursor          = #E0E0E0
-- background      = #151515

-- | This defines the font for the terminal.
fontConf :: FontConfig
fontConf =
  defaultFontConfig
    { fontFamily = "DejaVu Sans Mono Nerd Font"
    , fontSize = FontSizePoints 10
    }

main :: IO ()
main = do
  colExt <- createColourExtension colConf
  let termonadConf =
        defaultTMConfig
          { options =
              defaultConfigOptions
                { fontConfig = fontConf
                  -- Make sure the scrollbar is always visible.
                , showScrollbar = ShowScrollbarAlways
                }
          }
        `addColourExtension` colExt
  defaultMain termonadConf
