extends Move
class_name RaiseShield

@export var transition_timing : float = 0.4167
@export var movement_speed: float = 2
var blocked_hit_id: String

func check_relevance(input: InputPackage) -> String:
	if has_passed(transition_timing):
		return "Blocking"
	else:
		return name

func update(input: InputPackage, delta: float):
	var direction_3d = _camera_rig.transform * Vector3(input.direction.y, 0.0, -input.direction.x) + _actor.position
	_actor.look_at(direction_3d)
	var relative_direction_3d = _camera_rig.transform * Vector3(input.direction.x, 0.0, input.direction.y).normalized()
	var new_velocity = relative_direction_3d.normalized() * movement_speed
	_actor.velocity.x = lerp(_actor.velocity.x, new_velocity.x, delta * 8)
	_actor.velocity.z = lerp(_actor.velocity.z, new_velocity.z, delta * 8)
	super(input, delta)

func react_on_hit(hit_data: HitData, is_shield: bool = false):
	if is_shield:
		blocked_hit_id = hit_data.hit_id
	if blocked_hit_id != hit_data.hit_id:
		try_force_move("Stagger")
	else:
		hit_data.weapon.holder.state_machine.current_move.try_force_move("Stagger")
	hit_data.queue_free()

func on_enter_state():
	super()

func on_exit_state():
	pass
