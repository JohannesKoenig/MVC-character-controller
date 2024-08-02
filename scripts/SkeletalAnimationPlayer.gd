extends AnimationPlayer
class_name SkeletalAnimationPlayer


func _ready():
	configure_blending_times()

func configure_blending_times():
	for animation_1 in get_animation_list():
		for animation_2 in get_animation_list():
			set_blend_time(animation_1, animation_2, 0.2)

	set_blend_time(_get_animation_name("Idle"), _get_animation_name("Walking"), 0.4)
	set_blend_time(_get_animation_name("Walking"), _get_animation_name("Idle"), 0.4)


func _get_animation_name(state: String) -> String:
	return "character_animation_library/" + state
