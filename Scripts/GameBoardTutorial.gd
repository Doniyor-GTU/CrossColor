extends Node

export (int) var level = 1

var PressToStart_position = Vector2(0,0) setget set_PressToStart_pos

func _ready():
	$ColorRect/TopUi/Level.text = "LEVEL " + str(level)
	var val = 0
	$ColorRect/TopUi/ProgressBar.value  = val


func set_PressToStart_pos(value : Vector2):
	var x_pos = value.x
	var y_pos = value.y - get_node("ColorRect/Label").rect_size.y/2
	get_node("ColorRect/Label").rect_global_position = Vector2(x_pos, y_pos)

func _on_MenuButton_pressed():
	$CanvasLayer/PropertiesScreen.screen_in()


func _on_GiftScreen_double_btn(amount):
	if (str(level + 1) in LoadedScreens.levels) :
		GameDataManager.game_data["level"] = level + 1
		get_tree().change_scene_to(LoadedScreens.levels[str(level+1)])
	else:
		get_tree().change_scene_to(LoadedScreens.Home)
	GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + amount
	GameDataManager.save_game()


func _on_GiftScreen_no_thanks_btn(amount):
	if (str(level + 1) in LoadedScreens.levels) :
		GameDataManager.game_data["level"] = level + 1
		get_tree().change_scene_to(LoadedScreens.levels[str(level+1)])
	else:
		get_tree().change_scene_to(LoadedScreens.Home)
	GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + amount
	GameDataManager.save_game()
