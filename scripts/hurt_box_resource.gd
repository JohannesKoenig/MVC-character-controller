class_name HurtBoxResource extends Resource

@export var hurt_vector: Vector3 = Vector3.ZERO
@export var hurt_strength: float

signal is_hurt
signal take_damage(value: int)
