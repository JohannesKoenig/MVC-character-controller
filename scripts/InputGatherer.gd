extends Node
class_name InputGatherer

func gather_input() -> InputPackage:
	var input_package = InputPackage.new()
	input_package.direction = Input.get_vector(
		"Back",
		"Forward",
		"Left",
		"Right"
	)
	if input_package.direction != Vector2.ZERO:
		input_package.actions.append("Walking")
	
	if Input.is_action_just_pressed("Jump"):
		input_package.actions.append("Jump")

	if Input.is_action_just_pressed("Dodge"):
		input_package.actions.append("Dodge")
	
	if Input.is_action_just_pressed("Attack"):
		input_package.combat_actions.append("Attack")
		
	if Input.is_action_pressed("Block"):
		input_package.combat_actions.append("Block")
	
	input_package.actions.append("Idle")

	input_package.rotation_direction = Input.get_axis("Turn_Right", "Turn_Left")
	return input_package
	
