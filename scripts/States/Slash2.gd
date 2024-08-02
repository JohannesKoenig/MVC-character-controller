extends Move
class_name Slash2

@export var transition_timing : float = 0.6244
@export var movement_speed: float = 6

func check_relevance(input: InputPackage) -> String:
	if forced_move != "":
		return forced_move
	if has_passed(transition_timing):
		return super(input)
	else:
		return "Slash2"

func update(input: InputPackage, delta: float):
	var relative_direction_3d = _actor.global_basis.x
	var new_velocity = relative_direction_3d * movement_speed
	var velocity_multiplier = _move_data_mapper.interpolate_data("velocity_multiplier", get_progress())
	_actor.velocity.x = lerp(_actor.velocity.x, new_velocity.x * velocity_multiplier, delta * 8)
	_actor.velocity.z = lerp(_actor.velocity.z, new_velocity.z * velocity_multiplier, delta * 8)
	super(input, delta)

func on_enter_state():
	_actor.velocity = Vector3.ZERO
	super()
	_combat_system.get_active_weapon_object().set_hit_id(str(_start_time))

func on_exit_state():
	_combat_system.get_active_weapon_object().hit_box.hurt_box_ignore_list.clear()
	super()
