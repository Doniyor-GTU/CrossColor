extends Button

signal button_pressed(this_object)

export(int) var minute = 4
export(int) var second = 59
export(int) var coin_amount = 200

var is_active = true setget set_active, get_active
var left_min = 4
var left_sec = 59

# Called when the node enters the scene tree for the first time.
func _ready():
	left_min = minute
	left_sec = second
	if not GameDataManager.game_data["get_coin_time"]["is_stoped"]:
		left_min = GameDataManager.game_data["get_coin_time"]["min"]
		left_sec = GameDataManager.game_data["get_coin_time"]["sec"]
		self.is_active = false
	$time.text = get_time_text(left_min, left_sec)


func set_active(value):
	if value:
		$time.visible = false
		$icon.visible = true
		$icon2.visible = true
		disabled = false
	else:
		$time.visible = true
		$icon.visible = false
		$icon2.visible = false
		disabled = true
		$Timer.start()

func get_active():
	pass

func get_time_text(minn, secc):
	var txt 
	if minn < 10 and secc < 10:
		txt = "0" +  str(minn) + " : " + "0" + str(secc)
	elif minn < 10 and secc >= 10:
		txt = "0" +  str(minn) + " : " + str(secc)
	elif minn >= 10 and secc < 10:
		txt = str(minn) + " : " + "0" + str(secc)
	elif minn >= 10 and secc >= 10:
		txt = str(minn) + " : " + str(secc)
	return txt

func _on_Timer_timeout():
	if left_sec > 0:
		left_sec -= 1
		$time.text = get_time_text(left_min, left_sec)
	elif left_sec == 0 and left_min > 0:
		left_min -= 1
		left_sec = 59
		$time.text = get_time_text(left_min, left_sec)
	else:
		$Timer.stop()
		self.is_active = true
		left_min = minute
		left_sec = second
		$time.text = get_time_text(left_min, left_sec)
		GameDataManager.game_data["get_coin_time"]["is_stoped"] = true
	GameDataManager.game_data["get_coin_time"]["min"] = left_min
	GameDataManager.game_data["get_coin_time"]["sec"] = left_sec
	GameDataManager.save_game()


func _on_GetCoinButton_pressed():
	emit_signal("button_pressed", self)
