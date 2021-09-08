extends Node2D

export(int) var texture_code = 0

func _ready():
	pass


func move(from, to, time = 0.4):
	$Tween.interpolate_property(self, "position", from, to, time, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.start()

func move2(from, to, time = 0.4):
	$Tween2.interpolate_property(self, "scale", Vector2(1,1), Vector2(1.2,1.2), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween2.interpolate_property(self, "scale", Vector2(1.2,1.2), Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	$Tween2.interpolate_property(self, "position", from, to, time, Tween.TRANS_CIRC, Tween.EASE_IN, 0.2)
	$Tween2.start()
	yield(get_tree().create_timer(0.3 + time), "timeout")
	$Tween2.interpolate_property(self, "scale", Vector2(1,1), Vector2(0,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween2.start()

func set_texture(txt : Texture):
	$icon.texture = txt

func get_texture():
	return $icon.texture

func get_size():
	return $icon.rect_size

func zoom_effect():
	pass
