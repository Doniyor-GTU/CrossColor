extends Node

signal swiped(direction, start_position)
signal swiped_canceled(start_position)

export(float, 1.0, 1.5) var MAX_DIAGONAL_SLOPE = 1.3
export(int, 1, 50) var MIN_SWIPE_LENGTH = 5

#onready var wait_timer = $InputWaitTimer
onready var timer = $Timer
var swipe_start_position = Vector2()

func _input(event):
	#if wait_timer.is_stopped():
	# waits 1 sec for a new swipe
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	elif not timer.is_stopped():
		_end_detection(event.position)
		
func _start_detection(position):
	swipe_start_position = position
	timer.start()
	
func _end_detection(position):
	timer.stop()
	var swipe_length = sqrt(pow((position.x-swipe_start_position.x),2) + pow((position.y-swipe_start_position.y),2))
	if swipe_length < MIN_SWIPE_LENGTH:
		return
	var direction = (position - swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) >= MAX_DIAGONAL_SLOPE:
		return
	
	if abs(direction.x) > abs(direction.y):
		# Horizontal Swipe
		emit_signal("swiped", Vector2(-sign(direction.x), 0.0), swipe_start_position)
		#wait_timer.start()
	else:
		# Vertical Swipe
		emit_signal("swiped", Vector2(0.0, -sign(direction.y)), swipe_start_position)
		#wait_timer.start()


func _on_Timer_timeout():
	emit_signal("swiped_canceled", swipe_start_position)

