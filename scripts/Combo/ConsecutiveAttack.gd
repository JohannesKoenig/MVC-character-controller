extends Combo
class_name ConsecutiveAttack

@onready var _move: Move = $".."
@export var panic_timeout = 0.3
@export var combat_action_trigger: String

func is_triggered(input: InputPackage) -> bool:
	if _move.has_passed(panic_timeout) and input.actions.has(combat_action_trigger):
		return true
	return false
