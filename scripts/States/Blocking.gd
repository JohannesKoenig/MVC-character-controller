extends Move
class_name Blocking

@export var transition_timing : float = 0.4167
var blocked_hit_id: String

func check_relevance(input: InputPackage) -> String:
	var next_move = super(input)
	if next_move != "RaiseShield":
		return "LowerShield"
	else:
		return name

func update(input: InputPackage, delta: float):
	_actor.velocity = Vector3.ZERO
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
