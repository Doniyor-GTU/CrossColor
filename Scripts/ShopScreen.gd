extends Control

signal coin_add_btn_pressed
signal disable_adds
signal goto_gameboard

onready var coins_label = get_node("ColorRect/TopUI/Coins")
onready var coins_icon = get_node("ColorRect/TopUI/Coins/icon")
var coins_animation_node_path = preload("res://Scene/coins_animation.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var is_add_active = GameDataManager.game_data["is_add_active"]
	var current_coins = GameDataManager.game_data["coins"]
	$ColorRect/TopUI/Coins.text = str(current_coins)
	$ColorRect/ADDContent/NoAddButton.is_active = not is_add_active
	$ColorRect/ADDContent/NoAddButton.is_selected = not is_add_active


func screen_in(time = 0.1):
	modulate = Color(1,1,1,0)
	visible = true
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func screen_out(time = 0.1):
	emit_signal("goto_gameboard")
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	visible = false



func _on_GetCoinButton_button_pressed(this_object):
	emit_signal("coin_add_btn_pressed")


func _on_coin_animation_finished():
	var coins = GameDataManager.game_data["coins"]
	coins_label.text = str(coins)

func _on_NoAddButton_buy_button_pressed(this_btn):
	emit_signal("disable_adds")
	GameDataManager.game_data["is_add_active"] = false
	GameDataManager.save_game()
	this_btn.is_active = true
	this_btn.is_selected = true


func _on_BackButton_pressed():
	screen_out()


func _on_GameBoard_coin_add():
	var coins_animation_node = coins_animation_node_path.instance()
	$ColorRect/GetCoinButton.add_child(coins_animation_node)
	coins_animation_node.slide_animation(coins_icon.rect_global_position, 1.2)
	coins_animation_node.connect("coin_animation_finished", self, "_on_coin_animation_finished")
	var coins = GameDataManager.game_data["coins"]
	GameDataManager.game_data["coins"] = coins + $ColorRect/GetCoinButton.coin_amount
	GameDataManager.game_data["get_coin_time"]["is_stoped"] = false
	GameDataManager.save_game()
	$ColorRect/GetCoinButton.is_active = false
