# MVC-character-controller

An exercise in creating a 3d-third person character controller with "dark souls"-like movement. The goal was to implement the model-view-controller pattern to help with scaling complexity and allow for swapping components of the character for different ones.

## Noteworthy highlights
- The character is modeled, rigged and animated in blender and imported in *glb* file-format. Godots import settings were used to build a convenient pipeline for extracting assets from the glb-file like the aminations into separate binary resources. This allows for continuous modification of the project-file in blender and automatic imports of changes via the glb-file-import-pipeline.
- Animations were done without root motion and the motion was added in the state's behaviour instead - this allows for fully physically simulated movement (for example a character can fall down while dodge rolling from a cliff
- A combo system allows for chaining of moves / states in the state machine (Slash1 -> Slash2)
- Used an AnimationPlayer for interpolation of character properties like movement speed or attack and combo windows
- The top note of the character is not the physics object - The physics object was moved into the model instead (where it belongs) and validates the models move with the physical constraints of the game world
