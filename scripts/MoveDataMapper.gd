extends AnimationPlayer
class_name MoveDataMapper

@export var velocity_multiplier: float = 1.0
@export var damage_multiplier: float = 1.0
@export var can_damage: bool = false
@export var can_block: bool = false

var _current_move: String
var _current_animation: Animation

func set_move(move: String):
	_current_move = move
	if has_animation(move):
		_current_animation = get_animation(_current_move)
	else:
		_current_animation = null

func interpolate_data(parameter: String, progress: float) -> Variant:
	if not _current_animation:
		return
	if progress > _current_animation.length:
		return
	var index = _current_animation.find_track(_to_node_path(parameter), Animation.TYPE_VALUE)
	return _current_animation.value_track_interpolate(index, progress)

func _to_track_name(track: String) -> String:
	return "MoveDataMapper:" + track

func _to_node_path(track: String) -> String:
	return "Model/" + _to_track_name(track)
