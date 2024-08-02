class_name HurtBox extends Area3D

@export var state_machine: StateMachine
@export var is_shield: bool = false

func _ready():
	area_entered.connect(on_contact)

func on_contact(area: Area3D):
	if not area is WeaponHitBox:
		return
	var weapon_hit_box: WeaponHitBox = area
	if is_valid_connect(weapon_hit_box):
		weapon_hit_box.hurt_box_ignore_list.append(self)
		if state_machine:
			state_machine.current_move.react_on_hit(weapon_hit_box.get_hit_data(), is_shield)

func is_valid_connect(area: WeaponHitBox):
	if area.weapon.is_damage_active and not self in area.hurt_box_ignore_list:
		return true
	return false
