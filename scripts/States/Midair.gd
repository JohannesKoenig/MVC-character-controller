extends Move
class_name Midair


func check_relevance(input: InputPackage) -> String:
	check_combos(input)
	if _actor.is_on_floor():
		return "Landing"
	else:
		if _has_queued_move:
			_has_queued_move = false
			return queued_move
		return "Midair"

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	pass
