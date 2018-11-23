void WrappedDrawCube(Vector3 *position, float width, float height, float length, Color *color);
void WrappedDrawCubeWires(Vector3 *position, float width, float height, float length, Color *color);
void WrappedDrawBillboard(Camera3D *camera, Texture2D *texture, Vector3 *center, float size, Color *tint);
Material *WrappedLoadMaterial(const char *fileName);
Material *WrappedLoadMaterialDefault(void);
void WrappedUnloadMaterial(Material *material);
