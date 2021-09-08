extends Node


func _ready():
	$Background.texture = LoadedScreens.background_texture
	var current_level = GameDataManager.game_data["level"]
	if str(current_level) in LoadedScreens.levels:
		get_tree().change_scene_to(LoadedScreens.levels[str(current_level)])


func _on_Button_pressed():
	GameDataManager.game_data["level"] = 1
	GameDataManager.save_game()
	get_tree().change_scene_to(LoadedScreens.levels["1"])
