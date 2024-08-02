extends Move
class_name PlungeSlashMidair


func check_relevance(input: InputPackage) -> String:
	if _actor.is_on_floor():
		return "PlungeSlashEnd"
	else:
		return name

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	super()
