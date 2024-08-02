extends Move
class_name Jump

@export var transition_timing : float = 0.6244
@export var jump_timing: float = 0.1
@export var plunge_delay: float = 0.5
@export var jump_velocity: float = 6

var _jumped: bool = false

func check_relevance(input: InputPackage) -> String:
	check_combos(input)
	if has_passed(plunge_delay):
		if _has_queued_move:
			_has_queued_move = false
			_jumped = false
			return queued_move
	if has_passed(transition_timing):
		_jumped = false
		return "Midair"
	else:
		return "Jump"

func update(input: InputPackage, delta: float):
	if has_passed(jump_timing):
		if not _jumped:
			_jumped = true
			_actor.velocity.y += jump_velocity
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	pass
