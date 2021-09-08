extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SortButton_button_down():
	SoundManager.play_fixed_sound("slide")


func _on_SortButton_button_up():
	SoundManager.play_fixed_sound("slide")


func _on_grid_swiped():
	SoundManager.play_fixed_sound("slide")


func _on_grid_firework_added():
	#SoundManager.play_fixed_sound("confetti", -18)
	pass


func _on_grid_win():
	SoundManager.play_fixed_sound("win")
