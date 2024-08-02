extends Area3D
class_name WeaponHitBox

var hurt_box_ignore_list: Array[Area3D] = []
@onready var weapon: Weapon = $".."

func _ready():
	area_entered.connect(on_contact)

func on_contact(area: Node3D):
	pass
	
func get_hit_data() -> HitData:
	return weapon.get_hit_data()
	
