class_name PlayerCamera extends Node3D

var _camera_rig: Node3D
var _rig: Node3D

func accept_camera_rig(camera_rig: Node3D):
	_camera_rig = camera_rig

func accept_rig(rig: Node3D):
	_rig = rig

func _process(delta):
	if _camera_rig:
		rotation = _camera_rig.rotation
	if _rig:
		position = _rig.position
