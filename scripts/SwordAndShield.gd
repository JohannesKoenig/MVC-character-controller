extends Weapon
class_name SwordAndShield

@onready var hit_box: WeaponHitBox = $WeaponHitBox
var _hit_id: String

func _ready():
	basic_attacks = {
		"Attack": "Slash1",
		"Block": "RaiseShield"
	}

func get_hit_data() -> HitData:
	var hit_data = HitData.new()
	hit_data.damage = 10.0
	hit_data.hit_id = _hit_id
	hit_data.weapon = self
	return hit_data

func set_hit_id(hit_id: String):
	_hit_id = hit_id
