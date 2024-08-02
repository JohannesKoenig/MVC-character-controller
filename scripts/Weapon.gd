extends Node
class_name Weapon

@export var holder: Model
var basic_attacks: Dictionary
var is_damage_active: bool = false
var is_blocking_active: bool = false

func has_combat_action(combat_action: String) -> bool:
	return combat_action in basic_attacks.keys()

func map_combat_action(combat_action: String) -> String:
	return basic_attacks[combat_action]
