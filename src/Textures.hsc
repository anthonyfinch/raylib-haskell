{-# LANGUAGE ForeignFunctionInterface #-}
module Textures (

  -- * Loading/Unloading functions
  loadImage,
  -- TODO loadImageEx,
  -- TODO loadImagePro,
  -- TODO loadImageRaw,
  -- TODO exportImage,
  loadTexture,
  loadTextureFromImage,
  -- TODO loadRenderTexture,
  -- TODO unloadRenderTexture,
  -- TODO getImageData,
  -- TODO getImageDataNormalized,
  -- TODO getPixelDataSize,
  -- TODO getTextureData,
  -- TODO updateTexture,

  -- * Image manipulation functions
  -- TODO imageCopy,
  -- TODO imageToPOT,
  -- TODO imageFormat,
  -- TODO imageAlphaMask,
  -- TODO imageAlphaClear,
  -- TODO imageAlphaCrop,
  -- TODO imageAlphaPremultiply,
  -- TODO imageCrop,
  -- TODO imageResize,
  -- TODO imageResizeNN,
  -- TODO imageResizeCanvas,
  -- TODO imageMipmaps,
  -- TODO imageDither,
  -- TODO imageText,
  -- TODO imageTextEx,
  -- TODO imageDraw,
  -- TODO imageDrawRectangle,
  -- TODO imageDrawText,
  -- TODO imageDrawTextEx,
  -- TODO imageFlipVertical,
  -- TODO imageFlipHorizontal,
  -- TODO imageRotateCW,
  -- TODO imageRotateCCW,
  -- TODO imageColorTint,
  -- TODO imageColorInvert,
  -- TODO imageColorGrayscale,
  -- TODO imageColorContrast,
  -- TODO imageColorBrightness,
  -- TODO imageColorReplace,

  -- * Image generation functions
  -- TODO genImageColor,
  -- TODO genImageGradientV,
  -- TODO genImageGradientH,
  -- TODO genImageGradientRadial,
  -- TODO getImageChecked,
  -- TODO getImageWhiteNoise,
  -- TODO getImagePerlinNoise,
  -- TODO getImageCellular,

  -- * Texture2D configuration functions
  -- TODO getTextureMipmaps,
  -- TODO setTextureFilter,
  -- TODO setTextureWrap,

  -- * Texture2D drawing functions
  -- TODO drawTexture,
  -- TODO drawTextureV,
  drawTextureEx,
  -- TODO drawTextureRec,
  -- TODO drawTexturePro,

) where
import Foreign.C.String
import Foreign.C.Types
import Foreign.ForeignPtr
import Foreign.Marshal.Utils
import Foreign.Ptr
import Types

#include "raylib.h"
#include "textures.h"

foreign import ccall unsafe "textures.h WrappedLoadImage" c_WrappedLoadImage :: CString -> IO (Ptr Image)
loadImage :: String -> IO Image
loadImage filename =
  withCString filename $ \cFilename -> do
    imagePtr <- c_WrappedLoadImage cFilename
    Image <$> newForeignPtr c_WrappedUnloadImage imagePtr

foreign import ccall unsafe "textures.h &WrappedUnloadImage" c_WrappedUnloadImage :: FunPtr (Ptr Image -> IO ())
foreign import ccall unsafe "textures.h &WrappedUnloadTexture" c_WrappedUnloadTexture :: FunPtr (Ptr Texture2D -> IO ())

foreign import ccall unsafe "textures.h WrappedLoadTexture" c_WrappedLoadTexture :: CString -> IO (Ptr Texture2D)
loadTexture :: String -> IO Texture2D
loadTexture filename =
  withCString filename $ \cFilename -> do
    texturePtr <- c_WrappedLoadTexture cFilename
    Texture2D <$> newForeignPtr c_WrappedUnloadTexture texturePtr

foreign import ccall unsafe "textures.h WrappedLoadTextureFromImage" c_WrappedLoadTextureFromImage :: Ptr Image -> IO (Ptr Texture2D)
loadTextureFromImage :: Image -> IO Texture2D
loadTextureFromImage image =
  withImage image $ \imagePtr -> do
    texturePtr <- c_WrappedLoadTextureFromImage imagePtr
    Texture2D <$> newForeignPtr c_WrappedUnloadTexture texturePtr

foreign import ccall unsafe "textures.h WrappedDrawTextureEx" c_WrappedDrawTextureEx :: Ptr Texture2D -> Ptr Vector2 -> CFloat -> CFloat -> Ptr Color -> IO ()
drawTextureEx :: Texture2D -> Vector2 -> Float -> Float -> Color -> IO ()
drawTextureEx texture position rotation scale tint =
  withTexture2D texture $ \texturePtr ->
    with position $ \positionPtr ->
      with tint $ \tintPtr ->
        c_WrappedDrawTextureEx texturePtr positionPtr (realToFrac rotation) (realToFrac scale) tintPtr
