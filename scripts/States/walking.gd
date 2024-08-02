extends Move
class_name Walking

@export var movement_speed: float = 10.0

func check_relevance(input: InputPackage) -> String:
	if not _actor.is_on_floor():
		return "Midair"
	return super(input)

func update(input: InputPackage, delta: float):
	var direction_3d = _camera_rig.transform * Vector3(input.direction.y, 0.0, -input.direction.x) + _actor.position
	_actor.look_at(direction_3d)
	var relative_direction_3d = _camera_rig.transform * Vector3(input.direction.x, 0.0, input.direction.y).normalized()
	var new_velocity = relative_direction_3d.normalized() * movement_speed
	_actor.velocity.x = lerp(_actor.velocity.x, new_velocity.x, delta * 8)
	_actor.velocity.z = lerp(_actor.velocity.z, new_velocity.z, delta * 8)
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	pass
