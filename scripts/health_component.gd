class_name HealthComponent extends Node

@export var health_resource: HealthResource

func take_damage(value: int):
	health_resource.take_damage(value)

func restore_health(value: int):
	health_resource.restore_health(value)
