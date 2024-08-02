class_name HealthBar extends ProgressBar

@export var always_show: bool = false
@export var health_resource: HealthResourceResource:
	set(resource):
		health_resource = resource
		min_value = health_resource.min_health
		max_value = health_resource.base_health
		value = health_resource.current_health
		health_resource.damage_taken.connect(_on_damage_taken)
		health_resource.death.connect(_on_death)
		
func _ready():
	_hide()

func _on_damage_taken(damage: int):
	if health_resource._is_full_health():
		_hide()
	else:
		_show()
	value = health_resource.current_health
	
func _on_death():
	_hide()

func _show():
	visible = true

func _hide():
	if not always_show:
		visible = false
