extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	modulate = Color(1,1,1,0)

func screen_in(pos):
	rect_global_position = pos
	visible = true
	$Tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	
func screen_out():
	$Tween.interpolate_property(self, "modulate", modulate, Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	visible = false
