extends Node
class_name CombatSystem

var _move_sorter: MoveSorter

var weapons = {}

var active_weapon: String

func _ready():
	for weapon: Weapon in get_children():
		weapons[weapon.name] = weapon
	activate_weapon("SwordAndShield")

func accept_move_sorter(move_sorter: MoveSorter):
	_move_sorter = move_sorter

func translate_combat_actions(input: InputPackage) -> InputPackage:
	if not input.combat_actions.is_empty():
		input.sort_combat_actions(_move_sorter.sort_actions)
		if len(input.combat_actions) > 0:
			var next_combat_action: String = input.combat_actions[0]
			var active_weapon_object: Weapon= weapons[active_weapon]
			if active_weapon_object.has_combat_action(next_combat_action):
				var mapped_action = active_weapon_object.map_combat_action(next_combat_action)
				input.actions.append(mapped_action)
	return input

func activate_weapon(weapon: String):
	if weapon in weapons.keys():
		active_weapon = weapon

func get_active_weapon_object() -> Weapon:
	return weapons[active_weapon]
