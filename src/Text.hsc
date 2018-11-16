module Text (

  -- * Font loading/unloading functions
  getFontDefault,
  -- TODO loadFont,
  -- TODO loadFontEx,
  -- TODO loadFontData,
  -- TODO genImageFontAtlas,

  -- * Text drawing functions
  drawFPS,
  drawText,
  drawTextEx,

  -- * Text misc. functions
  -- TODO measureText,
  -- TODO measureTextEx,
  -- TODO formatText,
  -- TODO subText,
  -- TODO getGlyphIndex,

) where
import Foreign.C.String
import Foreign.C.Types
import Foreign.Marshal.Utils
import Foreign.Ptr
import Foreign.ForeignPtr
import Types

#include "raylib.h"
#include "text.h"

foreign import ccall unsafe "text.h WrappedGetFontDefault" c_WrappedGetFontDefault :: IO (Ptr Font)
getFontDefault :: IO Font
getFontDefault = do
  fontPtr <- c_WrappedGetFontDefault
  Font <$> newForeignPtr c_WrappedUnloadFont fontPtr

foreign import ccall unsafe "text.h &WrappedUnloadFont" c_WrappedUnloadFont :: FunPtr (Ptr Font -> IO ())

foreign import ccall unsafe "raylib.h DrawFPS" c_DrawFPS :: CInt -> CInt -> IO ()
drawFPS :: Int -> Int -> IO ()
drawFPS posX posY = c_DrawFPS (fromIntegral posX) (fromIntegral posY)

foreign import ccall unsafe "text.h WrappedDrawText" c_WrappedDrawText :: CString -> CInt -> CInt -> CInt -> Ptr Color -> IO ()
drawText :: String -> Int -> Int -> Int -> Color -> IO ()
drawText text posX posY fontSize color =
  withCString text $ \textPtr ->
    with color $ \colorPtr ->
      c_WrappedDrawText textPtr (fromIntegral posX) (fromIntegral posY) (fromIntegral fontSize) colorPtr

foreign import ccall unsafe "text.h WrappedDrawTextEx" c_WrappedDrawTextEx :: Ptr Font -> CString -> Ptr Vector2 -> CFloat -> CFloat -> Ptr Color -> IO ()
drawTextEx :: Font -> String -> Vector2 -> Float -> Float -> Color -> IO ()
drawTextEx (Font fontForeignPtr) text position fontSize spacing color =
  withForeignPtr fontForeignPtr $ \fontPtr ->
    withCString text $ \textPtr ->
      with position $ \positionPtr ->
        with color $ \colorPtr ->
          c_WrappedDrawTextEx fontPtr textPtr positionPtr (realToFrac fontSize) (realToFrac spacing) colorPtr