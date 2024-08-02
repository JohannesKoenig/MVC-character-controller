extends Move
class_name Landing

@export var transition_timing : float = 0.625


func check_relevance(input: InputPackage) -> String:
	if _actor.is_on_floor():
		return super(input)
	else:
		if has_passed(transition_timing):
			return super(input)
		else:
			return "Landing"

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	pass
