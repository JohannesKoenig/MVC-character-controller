extends Move
class_name Stagger

@export var transition_timing : float = 0.4167


func check_relevance(input: InputPackage) -> String:
	if has_passed(transition_timing):
		return super(input)
	else:
		return name

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	_actor.velocity = Vector3.ZERO
	super()

func on_exit_state():
	pass
