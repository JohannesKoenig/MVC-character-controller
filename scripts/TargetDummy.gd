extends Node3D
class_name TargetDummy

@onready var model: Model = $Model
@onready var visuals: Visuals = $Visuals

func _ready():
	model.set_initial_transform(transform)
	visuals.accept_model(model)


func _process(delta):
	var input_package = InputPackage.new()
	input_package.actions = ["RaiseShield"]
	
	model.update(input_package, delta)
	
	# visuals follow model
	
	# place top-level node according to model
	_update_transform()

	# clean up to avoid memory leak
	input_package.queue_free()


func _update_transform():
	position = model.actor.position

