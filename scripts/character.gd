extends Node3D

@onready var input := $Input
@onready var model := $Model
@onready var visuals := $Visuals

func _ready():
	model.set_initial_transform(transform)
	visuals.accept_model(model)


func _process(delta):
	var input_package = input.gather_input()
	model.update(input_package, delta)
	
	# visuals follow model
	
	# place top-level node according to model
	_update_transform()

	# clean up to avoid memory leak
	input_package.queue_free()


func _update_transform():
	position = model.actor.position

