extends Move
class_name PlungeSlashStart

@export var transition_timing : float = 0.4583


func check_relevance(input: InputPackage) -> String:
	if has_passed(transition_timing):
		return "PlungeSlashMidair"
	else:
		return name

func update(input: InputPackage, delta: float):
	super(input, delta)

func on_enter_state():
	super()
	_combat_system.get_active_weapon_object().set_hit_id(str(_start_time))

func on_exit_state():
	super()
