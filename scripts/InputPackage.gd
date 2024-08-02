extends Node
class_name InputPackage

var direction: Vector2
var rotation_direction: float

var actions = []
var combat_actions = []


func sort_actions(sorting_function: Callable):
	actions.sort_custom(sorting_function)

func sort_combat_actions(sorting_function: Callable):
	combat_actions.sort_custom(sorting_function)
