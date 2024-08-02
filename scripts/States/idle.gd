extends Move
class_name Idle

func check_relevance(input: InputPackage) -> String:
	if not _actor.is_on_floor():
		return "Midair"
	return super(input)

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	_actor.velocity = Vector3.ZERO
	super()

func on_exit_state():
	pass
