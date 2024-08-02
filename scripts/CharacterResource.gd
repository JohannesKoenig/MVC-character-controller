extends Node
class_name CharacterResource

@export var max_resource: int = 100
var current_resource: int

var resource_name: String

func filter_actions(move: Move) -> bool:
	return enough_resource(move.stamina_cost)

func enough_resource(value: int):
	return current_resource >= value

func use_resource(value: int):
	current_resource = max(0,current_resource - value)

func gain_resource(value: int):
	current_resource = min(current_resource + value, max_resource)

func get_actions_filter(moves: Dictionary) -> Callable:
	return func(move_name: String) -> bool: return resource_name in moves[move_name].resource_costs and enough_resource(moves[move_name].resource_costs[resource_name])
