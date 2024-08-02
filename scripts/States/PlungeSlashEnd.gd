extends Move
class_name PlungeSlashEnd


@export var transition_timing : float = 0.4583


func check_relevance(input: InputPackage) -> String:
	if forced_move != "":
		return forced_move
	if has_passed(transition_timing):
		return super(input)
	else:
		return name

func update(input: InputPackage, delta: float):
	_actor.velocity.x = 0
	_actor.velocity.z = 0
	super(input, delta)

func on_enter_state():
	super()

func on_exit_state():
	_combat_system.get_active_weapon_object().hit_box.hurt_box_ignore_list.clear()
	super()
