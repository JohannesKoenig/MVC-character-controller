class_name Visuals extends Node

var model: Model
@onready var mesh: MeshInstance3D = $Mesh
@onready var player_camera: PlayerCamera = $CameraMount
@onready var hand_rig_l: Node3D = $Mesh/HandRigL
@onready var hand_rig_r: Node3D = $Mesh/HandRigR

func accept_model(model: Model):
	self.model = model
	mesh.skeleton = model.skeleton.get_path()
	player_camera.accept_camera_rig(model.camera_rig)
	player_camera.accept_rig(model.rig)

func _process(delta):
	mesh.transform = model.actor.transform
	hand_rig_l.transform = model.hand_rig_l.transform
	hand_rig_r.transform = model.hand_rig_r.transform
