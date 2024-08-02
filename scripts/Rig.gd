extends Node3D
class_name Rig

@onready var _actor: CharacterBody3D = $"../CharacterBody3D"

func _process(delta):
	transform = _actor.transform
