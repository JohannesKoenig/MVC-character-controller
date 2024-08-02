extends Node
class_name Model

@onready var actor: CharacterBody3D = $CharacterBody3D
@onready var camera_rig: Node3D = $CameraRig
@onready var rig: Node3D = $rig
@onready var state_machine: StateMachine = $StateMachine
@onready var skeleton: Skeleton3D = $rig/Skeleton3D
@onready var animation_player: AnimationPlayer = $SkeletalAnimationPlayer
@onready var move_data_mapper: MoveDataMapper = $MoveDataMapper
@onready var combat_system: CombatSystem = $CombatSystem
@onready var resource_system: ResourceSystem = $ResourceSystem
@onready var hurt_box: HurtBox = $HurtBox
@onready var hand_rig_l: BoneAttachment3D = $rig/Skeleton3D/HandRigL
@onready var hand_rig_r: BoneAttachment3D = $rig/Skeleton3D/HandRigR


func _ready():
	state_machine.accept_actor(actor)
	state_machine.accept_animation_player(animation_player)
	state_machine.accept_camera_rig(camera_rig)
	state_machine.accept_move_data_mapper(move_data_mapper)
	state_machine.accept_combat_system(combat_system)
	state_machine.accept_resource_system(resource_system)

func set_initial_transform(transform: Transform3D):
	actor.transform = transform

func update(input: InputPackage, delta: float):
	# map combat actions
	input = combat_system.translate_combat_actions(input)
	# update state machine
	state_machine.update(input, delta)
	# execute physics
	actor.move_and_slide()
	
