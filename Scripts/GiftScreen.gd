extends Control

signal no_thanks_btn(amount)
signal double_btn(amount)

var coin_amounts = [50, 50, 50, 50, 50, 50, 50, 50, 50, 50,
					 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 
					150, 150, 150, 150, 150, 150,
					200, 200, 200,
					 250]

var rnd = RandomNumberGenerator.new()
var coin_amount = coin_amounts[1]

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	var random_index = rnd.randi_range(0,coin_amounts.size()-1)
	coin_amount = coin_amounts[random_index]
	$coin_amount.text = "+" + str(coin_amount)
	$Particles2D.position = $Backward.rect_global_position + $Backward.rect_size/2
	$Particles2D2.position = $Backward.rect_global_position + $Backward.rect_size/2

func screen_in():
	modulate = Color(1,1,1,0)
	visible = true
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	#yield(get_tree().create_timer(1.2), "timeout")
	#$AnimationPlayer.play("Rotate")


func _on_NextButton_pressed():
	emit_signal("no_thanks_btn", coin_amount)


func _on_2XButton_pressed():
	emit_signal("double_btn", 2*coin_amount)
