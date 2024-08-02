extends Move
class_name Dodge

@export var transition_timing : float = 1.25
@export var movement_speed: float = 6

func check_relevance(input: InputPackage) -> String:
	check_combos(input)
	if has_passed(transition_timing):
		if _has_queued_move:
			_has_queued_move = false
			return queued_move
		else:
			return super(input)
	else:
		return name

func update(input: InputPackage, delta: float):
	var relative_direction_3d = _actor.global_basis.x
	var new_velocity = relative_direction_3d * movement_speed
	_actor.velocity.x = lerp(_actor.velocity.x, new_velocity.x, delta * 8)
	_actor.velocity.z = lerp(_actor.velocity.z, new_velocity.z, delta * 8)
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	super()
