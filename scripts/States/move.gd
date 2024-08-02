extends Node
class_name Move

@export var priority: int
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var rotation_speed: float = 2.0
@export var resource_costs: Dictionary = {
	"Stamina": 0,
	"Health": 0
}

var _actor: CharacterBody3D
var _move_data_mapper: MoveDataMapper
var _move_sorter: MoveSorter
var _camera_rig: Node3D
var _start_time: float
var _has_queued_move = false
var _combat_system: CombatSystem
var _resource_system: ResourceSystem
var queued_move: String

@onready var state_machine: StateMachine = $".."

var forced_move: String = ""

func accept_combat_system(combat_system: CombatSystem):
	_combat_system = combat_system

func accept_resource_system(resource_system: ResourceSystem):
	_resource_system = resource_system

func accept_actor(actor: CharacterBody3D):
	_actor = actor

func accept_move_data_mapper(move_data_mapper: MoveDataMapper):
	_move_data_mapper = move_data_mapper

func accept_move_sorter(sorter: MoveSorter):
	_move_sorter = sorter	

func accept_camera_rig(camera_rig: Node3D):
	_camera_rig = camera_rig

func react_on_hit(hit_data: HitData, is_shield: bool = false):
	try_force_move("Stagger")
	hit_data.queue_free()

func check_relevance(input: InputPackage) -> String:
	if forced_move != "":
		var temp = forced_move
		forced_move = ""
		return temp
	input.actions.sort_custom(_move_sorter.sort_actions)
	for filter in _resource_system.get_actions_filters(state_machine.moves):
		input.actions = input.actions.filter(filter)
	return input.actions[0]

func check_combos(input: InputPackage):
	for combo: Combo in get_children():
		if combo.is_triggered(input):
			_has_queued_move = true
			queued_move = combo.triggered_move

func update(input: InputPackage, delta: float):
	var can_damage = _move_data_mapper.interpolate_data("can_damage", get_progress())
	var can_block = _move_data_mapper.interpolate_data("can_block", get_progress())
	var active_weapon_object = _combat_system.get_active_weapon_object()
	if active_weapon_object:
		if can_damage:
			active_weapon_object.is_damage_active = can_damage
		else:
			active_weapon_object.is_damage_active = false
		if can_block:
			active_weapon_object.is_blocking_active = can_block
		else:
			active_weapon_object.is_blocking_active = false
	
	_camera_rig.rotate_y(input.rotation_direction * rotation_speed * delta)
	_actor.velocity.y -= gravity * delta

func mark_enter_start():
	_start_time = Time.get_unix_time_from_system()

func get_progress() -> float:
	var now = Time.get_unix_time_from_system()
	return now - _start_time

func has_passed(time: float) -> bool:
	return get_progress() > time

func is_before(time: float) -> bool:
	return get_progress() <= time

func is_between(start: float, end: float) -> bool:
	return has_passed(start) and is_before(end)

func on_enter_state():
	mark_enter_start()
	for resource_name in resource_costs.keys():
		var resource_cost = resource_costs[resource_name]
		_resource_system.resource_map[resource_name].use_resource(resource_cost)
	

func on_exit_state():
	_combat_system.get_active_weapon_object().is_damage_active = false
	_combat_system.get_active_weapon_object().is_blocking_active = false
	forced_move = ""

func try_force_move(move: String):
	if forced_move == "":
		forced_move = move
		return
	var moves = [forced_move, move]
	moves.sort_custom(_move_sorter.sort_actions)
	forced_move = moves[0]

