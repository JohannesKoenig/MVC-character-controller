extends Node3D
class_name CameraRig

@onready var _actor: CharacterBody3D = $"../CharacterBody3D"

func _process(delta):
	rotation = _actor.position
	pass
