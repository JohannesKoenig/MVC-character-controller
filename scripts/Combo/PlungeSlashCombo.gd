extends Combo
class_name PlungeSlashCombo

@onready var _move: Move = $".."
@export var panic_timeout = 0.3

func is_triggered(input: InputPackage) -> bool:
	if _move.has_passed(panic_timeout) and input.actions.has("Slash1"):
		return true
	return false
