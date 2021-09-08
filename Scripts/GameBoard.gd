extends Node

signal next_level
signal shuffle_grid
signal double_gift
signal coin_add

export (int) var level = 1

var PressToStart_position = Vector2(0,0) setget set_PressToStart_pos
var current_reward_button = ""
var double_gift_coin_amount = 0

#var banner_load_tries = 0
var reward_load_tries = 0
var interstitial_load_tries = 0

func _ready():
#	check_ads()
#	AddManager.connect("rewarded", self, "_on_AdMob_rewarded")
	set_level_and_progressBar()
	

#func check_ads():
#	if not AddManager.is_banner_showing:
#		AddManager.show_banner()
#	if not AddManager.is_reward_video_loaded():
#		AddManager.load_reward_video()
#	if not AddManager.is_interstitial_loaded():
#		AddManager.load_interstitial()


func set_level_and_progressBar():
	$ColorRect/TopUi/Level.text = "LEVEL " + str(level)
	var val = (level % 10) 
	if val == 0:
		$ColorRect/TopUi/ProgressBar.value  = 10
	else:
		$ColorRect/TopUi/ProgressBar.value  = val


func set_PressToStart_pos(value : Vector2):
	# x value is set automatically to center
	var y_pos = value.y - get_node("ColorRect/Label").rect_size.y/2
	get_node("ColorRect/Label").rect_global_position.y = y_pos

func _on_MenuButton_pressed():
	$CanvasLayer/PropertiesScreen.screen_in()
	$grid.game_state = $grid.STOP


func _on_GiftScreen_double_btn(amount):
	double_gift_coin_amount = amount
#	AddManager.show_reward_video("DoubleGift")
	GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + double_gift_coin_amount
	GameDataManager.save_game()
	double_gift_coin_amount = 0
	if (str(level + 1) in LoadedScreens.levels) :
		get_tree().change_scene_to(LoadedScreens.levels[str(level+1)])
	else:
		get_tree().change_scene_to(LoadedScreens.Home)


#func _on_GameBoard_double_gift():
#	GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + double_gift_coin_amount
#	GameDataManager.save_game()
#	double_gift_coin_amount = 0
#	if (str(level + 1) in LoadedScreens.levels) :
#		get_tree().change_scene_to(LoadedScreens.levels[str(level+1)])
#	else:
#		get_tree().change_scene_to(LoadedScreens.Home)
	

func _on_GiftScreen_no_thanks_btn(amount):
#	AddManager.show_interstitial()
	GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + amount
	GameDataManager.save_game()
	if (str(level + 1) in LoadedScreens.levels) :
		get_tree().change_scene_to(LoadedScreens.levels[str(level+1)])
	else:
		get_tree().change_scene_to(LoadedScreens.Home)


#func _on_AdMob_rewarded(reward_type):
#	if reward_type == "NextLevelButton":
#		emit_signal("next_level")
#	elif reward_type == "ShuffleButton":
#		emit_signal("shuffle_grid")
#	elif reward_type == "DoubleGift":
#		emit_signal("double_gift")
#	elif reward_type == "CoinAddButton":
#		emit_signal("coin_add")


#func _on_Shop_coin_add_btn_pressed():
#	AddManager.show_reward_video("CoinAddButton")


#func _on_grid_show_interstitial_add():
#	AddManager.show_interstitial()


#func _on_Shop_disable_adds():
#	AddManager.is_add_active = false
#	AddManager.hide_banner()
