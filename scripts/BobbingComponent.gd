class_name BobbingComponent extends Node

@export var bobbing_offset: float = 10.0
@export var bobbing_cycle_duration: float = 5.0
@export var active: bool = true
# Called when the node enters the scene tree for the first time.
var parent: Node3D 
var start_position
var tween: Tween

func _ready():
	parent = get_parent()
	start_position = parent.position
	_create_tween()
	
	

func _create_tween():
	if tween:
		tween.kill()
	if active:
		tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(parent, "position:y", start_position.y + bobbing_offset, bobbing_cycle_duration / 2)
		tween.chain().tween_property(parent, "position:y", start_position.y, bobbing_cycle_duration / 2)
		tween.finished.connect(_create_tween)
