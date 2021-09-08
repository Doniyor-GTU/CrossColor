extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	pass

func start_show_animation(pos):
	#visible = true
	var animation = $AnimationPlayer.get_animation("show_animation")
	animation.track_set_key_value(0,0, pos)
	animation.track_set_key_value(0,1, pos + Vector2(20,0))
	$AnimationPlayer.play("show_animation")
	z_index = 2

func start_swipe_animation(initial_pos, target_pos, swipe_direction : bool):
	visible = true
	# if swipe_direction == true then Horizontal swipe, else Vertical swipe
	if swipe_direction == true:
		$Vertical_swipe_hand.visible = false
		$Horizontal_swipe_hand.visible = true
	else:
		$Vertical_swipe_hand.visible = true
		$Horizontal_swipe_hand.visible = false
	var animation = $AnimationPlayer.get_animation("swipe_animation")
	animation.track_set_key_value(0,0, initial_pos)
	animation.track_set_key_value(0,1, target_pos)
	$AnimationPlayer.play("swipe_animation")
	z_index = 2

func stop_animation():
	visible = false
	$AnimationPlayer.stop()
