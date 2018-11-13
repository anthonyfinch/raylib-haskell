#include <stdlib.h>
#include "raylib.h"

/////////////////////////////////////////////////////////////////////////////////
// Wrapped Unloaders
/////////////////////////////////////////////////////////////////////////////////

void WrappedUnloadImage(Image *image) {
  UnloadImage(*image);
  free(image);
}

void WrappedUnloadTexture(Texture2D *texture) {
  UnloadTexture(*texture);
  free(texture);
}

void WrappedUnloadRenderTexture(RenderTexture2D *texture) {
  UnloadRenderTexture(*texture);
  free(texture);
}

void WrappedUnloadFont(Font *font) {
  UnloadFont(*font);
  free(font);
}

void WrappedUnloadModel(Model *model) {
  UnloadModel(*model);
  free(model);
}

void WrappedUnloadMaterial(Material *material) {
  UnloadMaterial(*material);
  free(material);
}

void WrappedUnloadShader(Shader *shader) {
  UnloadShader(*shader);
  free(shader);
}

void WrappedUnloadWave(Wave *wave) {
  UnloadWave(*wave);
  free(wave);
}

void WrappedUnloadSound(Sound *sound) {
  UnloadSound(*sound);
  free(sound);
}

void WrappedUnloadMusicStream(Music *music) {
  UnloadMusicStream(*music);
  free(music);
}

void WrappedCloseAudioStream(AudioStream *audioStream) {
  CloseAudioStream(*audioStream);
  free(audioStream);
}

/////////////////////////////////////////////////////////////////////////////////
// Core
/////////////////////////////////////////////////////////////////////////////////

void WrappedGetMouseRay(Vector2 mousePosition, Camera3D camera, Ray *result) {
  *result = GetMouseRay(mousePosition, camera);
}

void WrappedGetWorldToScreen(Vector3 position, Camera3D camera, Vector2 *result) {
  *result = GetWorldToScreen(position, camera);
}

void WrappedGetCameraMatrix(Camera3D camera, Matrix *result) {
  *result = GetCameraMatrix(camera);
}

void WrappedGetMousePosition(Vector2 *result) {
  *result = GetMousePosition();
}

/////////////////////////////////////////////////////////////////////////////////
// Shapes
/////////////////////////////////////////////////////////////////////////////////

void WrappedGetCollisionRec(Rectangle rec1, Rectangle rec2, Rectangle *result) {
  *result = GetCollisionRec(rec1, rec2);
}

/////////////////////////////////////////////////////////////////////////////////
// Textures
/////////////////////////////////////////////////////////////////////////////////

Image *WrappedLoadImage(const char *fileName) {
  Image *result = malloc(sizeof *result);
  *result = LoadImage(fileName);
  return result;
}

Texture2D *WrappedLoadTexture(const char *fileName) {
  Texture2D *result = malloc(sizeof *result);
  *result = LoadTexture(fileName);
  return result;
}

/////////////////////////////////////////////////////////////////////////////////
// Text
/////////////////////////////////////////////////////////////////////////////////

Font *WrappedGetFontDefault(void) {
  Font *result = malloc(sizeof *result);
  *result = GetFontDefault();
  return result;
}

Font *WrappedLoadFont(const char *fileName) {
  Font *result = malloc(sizeof *result);
  *result = LoadFont(fileName);
  return result;
}
