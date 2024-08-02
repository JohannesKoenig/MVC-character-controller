extends Node3D
class_name BoneRig

@export var bone_name: String
@onready var skeleton: Skeleton3D = $".."

var _bone_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	_bone_index = skeleton.find_bone(bone_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = skeleton.get_bone_pose(_bone_index)
