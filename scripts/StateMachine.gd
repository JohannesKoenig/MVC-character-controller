class_name StateMachine extends Node


var _actor: CharacterBody3D
var _animation_player: AnimationPlayer
var _camera_rig: Node3D
var _move_data_mapper: MoveDataMapper
var _combat_system: CombatSystem
var _resource_system: ResourceSystem
var current_move: Move

var _move_sorter: MoveSorter

var moves = {}

func accept_resource_system(resource_system: ResourceSystem):
	_resource_system = resource_system
	for move in moves.values():
		move.accept_resource_system(_resource_system)

func accept_actor(actor: CharacterBody3D):
	_actor = actor
	for move in moves.values():
		move.accept_actor(_actor)

func accept_combat_system(combat_system: CombatSystem):
	_combat_system = combat_system
	_combat_system.accept_move_sorter(_move_sorter)
	for move in moves.values():
		move.accept_combat_system(_combat_system)

func accept_move_data_mapper(move_data_mapper: MoveDataMapper):
	_move_data_mapper = move_data_mapper
	for move in moves.values():
		move.accept_move_data_mapper(move_data_mapper)

func accept_animation_player(animation_player: AnimationPlayer):
	_animation_player = animation_player

func accept_camera_rig(camera_rig: Node3D):
	_camera_rig = camera_rig
	for move in moves.values():
		move.accept_camera_rig(camera_rig)

func _ready():
	for child in get_children():
		if child is Move:
			moves[child.name] = child
	
	_move_sorter = MoveSorter.new()
	_move_sorter.accept_move_dict(moves)
	
	for move in moves.values():
		move.accept_move_sorter(_move_sorter)
	

func update(input: InputPackage, delta: float):
	if not current_move:
		switch_to("Idle")
	var relevance = current_move.check_relevance(input)
	if relevance != current_move.name:
		switch_to(relevance)
	current_move.update(input, delta)

func switch_to(state: String):
	if current_move:
		current_move.on_exit_state()
	current_move = moves[state]
	_move_data_mapper.set_move(state)
	current_move.on_enter_state()
	_animation_player.play("character_animation_library/" + current_move.name)

