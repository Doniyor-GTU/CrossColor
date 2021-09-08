extends Control

signal coin_animation_finished
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func slide_animation(target_pos, time = 0.5):
	var ease_type = Tween.EASE_IN_OUT
	var trans_type = Tween.TRANS_CUBIC
	var wait_time = 0.5
	$Tween.interpolate_property($icon, "rect_global_position", $icon.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.interpolate_property($icon2, "rect_global_position", $icon2.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.interpolate_property($icon3, "rect_global_position", $icon3.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.interpolate_property($icon4, "rect_global_position", $icon4.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.interpolate_property($icon5, "rect_global_position", $icon5.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.interpolate_property($icon6, "rect_global_position", $icon6.rect_global_position, target_pos, time, trans_type, ease_type, wait_time)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	emit_signal("coin_animation_finished")
	queue_free()
	
