extends Node
class_name CopyTransform


@export var target: Node3D
@export var to_copy_from: Node3D
@export var global: bool = false

func _ready():
	if not target:
		target = get_parent()

func _process(delta):
	if to_copy_from:
		if global:
			target.global_transform = to_copy_from.global_transform
		else:
			target.transform = to_copy_from.transform
