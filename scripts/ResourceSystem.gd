extends Node
class_name ResourceSystem

var resource_map = {}

func _ready():
	for resource in get_children():
		resource_map[resource.resource_name] = resource

func get_actions_filters(moves: Dictionary) -> Array[Callable]:
	var filters: Array[Callable] = []
	for resource in resource_map.values():
		filters.append(resource.get_actions_filter(moves))
	return filters
