{-# LANGUAGE ForeignFunctionInterface #-}
module Internal.Mvp where
import Data.Coerce
import Data.Word
import Foreign.ForeignPtr
import Foreign.Marshal.Alloc
import Foreign.Marshal.Utils
import Foreign.Storable

#include "raylib.h"
#include "Mvp.h"

data Vector2 = Vector2 Float Float deriving Show

{# pointer *Vector2 as Vector2Ptr -> Vector2 #}

instance Storable Vector2 where
  sizeOf = const {# sizeof Vector2 #}
  alignment = const {# alignof Vector2 #}
  peek p = do
    x <- realToFrac <$> {# get Vector2.x #} p
    y <- realToFrac <$> {# get Vector2.y #} p
    pure $ Vector2 x y
  poke p (Vector2 x y) = do
    {# set Vector2.x #} p (realToFrac x)
    {# set Vector2.y #} p (realToFrac y)

data Color = Color Word8 Word8 Word8 Word8

{# pointer *Color as ColorPtr -> Color #}

instance Storable Color where
  sizeOf = const {# sizeof Color #}
  alignment = const {# alignof Color #}
  peek p = do
    r <- fromIntegral <$> {# get Color.r #} p
    g <- fromIntegral <$> {# get Color.g #} p
    b <- fromIntegral <$> {# get Color.b #} p
    a <- fromIntegral <$> {# get Color.a #} p
    pure $ Color r g b a
  poke p (Color r g b a) = do
    {# set Color.r #} p (fromIntegral r)
    {# set Color.g #} p (fromIntegral g)
    {# set Color.b #} p (fromIntegral b)
    {# set Color.a #} p (fromIntegral a)

data Rectangle = Rectangle Float Float Float Float

{# pointer *Rectangle as RectanglePtr -> Rectangle #}

instance Storable Rectangle where
  sizeOf = const {# sizeof Rectangle #}
  alignment = const {# alignof Rectangle #}
  peek p = do
    x      <- realToFrac <$> {# get Rectangle.x #}      p
    y      <- realToFrac <$> {# get Rectangle.y #}      p
    width  <- realToFrac <$> {# get Rectangle.width #}  p
    height <- realToFrac <$> {# get Rectangle.height #} p
    pure $ Rectangle x y width height
  poke p (Rectangle x y width height) = do
    {# set Rectangle.x #}      p (realToFrac x)
    {# set Rectangle.y #}      p (realToFrac y)
    {# set Rectangle.width #}  p (realToFrac width)
    {# set Rectangle.height #} p (realToFrac height)

{# pointer *Font foreign finalizer WrappedUnloadFont as unloadFont newtype #}

fontBaseSize :: Font -> IO Int
fontBaseSize f = fromIntegral <$> withForeignPtr (coerce f) {# get Font.baseSize #}

{# fun unsafe InitWindow as ^
  {`Int', `Int', `String'} -> `()' #}

{# fun unsafe CloseWindow as ^
  {} -> `()' #}

{# fun unsafe DrawRectangleRec as ^
  {with* %`Rectangle', with* %`Color'} -> `()' #}

{# fun unsafe BeginDrawing as ^
  {} -> `()' #}

{# fun unsafe EndDrawing as ^
  {} -> `()' #}

{# fun unsafe ClearBackground as ^
  {with* %`Color'} -> `()' #}

{# fun unsafe WrappedGetFontDefault as getFontDefault
  {} -> `Font' #}

{# fun unsafe DrawTextEx as ^
  {%`Font', `String', with* %`Vector2', `Float', `Float', with* %`Color'} -> `()' #}

{# fun unsafe DrawFPS as ^
  {`Int', `Int'} -> `()' #}

{# fun unsafe WrappedGetMousePosition as getMousePosition
  {alloca- `Vector2Ptr'} -> `Vector2' peek* #}