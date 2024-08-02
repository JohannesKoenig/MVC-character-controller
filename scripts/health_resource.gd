class_name HealthResourceResource extends Resource

@export var base_health: int
@export var min_health: int = 0
@export var current_health: int

# If something should try to manipulate the health of this resource, a signal on
# request_take_damage should be emitted. This is in place to allow any 
# (state machines, buffs, ...) middlewares to apply before deciding whether
# damage and what amount will be taken. (Same fore restoring health)
signal request_take_damage(value: int)
signal damage_taken(value: int)

signal request_restore_health(value: int)
signal health_restored(value: int)

signal death

func take_damage(value: int):
	if is_dead():
		return
	if _would_kill(value):
		current_health = 0
		damage_taken.emit(value)
		death.emit()
		return
	else:
		current_health = _clamp_health(current_health - value)
		damage_taken.emit(value)

func restore_health(value: int):
	if _is_full_health():
		return
	health_restored.emit(value)
	current_health = _clamp_health(current_health + value)


func is_dead() -> bool:
	return current_health == min_health

func _is_full_health() -> bool:
	return current_health == base_health

func _clamp_health(value: int) -> int:
	return min(base_health, max(min_health, value))

func _would_kill(value: int) -> bool:
	return (current_health - value) <= min_health
