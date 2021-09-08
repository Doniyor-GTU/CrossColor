extends "res://Scripts/SortButton.gd"

var is_tutorial_end = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hand.global_position = Vector2(rect_size.x + 10, rect_size.y/2) + rect_global_position
	$Hand.start_show_animation($Hand.position)

func hide_tutorials():
	if not is_tutorial_end:
		is_tutorial_end = true
		$Hand.queue_free()
		$Label.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
