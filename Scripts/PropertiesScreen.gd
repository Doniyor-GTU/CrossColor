extends ColorRect

export (Texture) var sound_on_texture
export (Texture) var sound_off_texture
export (Texture) var vibrate_on_texture
export (Texture) var vibrate_off_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	modulate = Color(1,1,1,0)
	set_sound_texture()
	set_vibration_texture()

func screen_in(time = 0.1):
	visible = true
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func screen_out(time = 0.1):
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	visible = false

func _on_Button_pressed():
	get_node("../../grid").game_state = get_node("../../grid").PLAY
	screen_out()


func _on_ShopButton_pressed():
	screen_out(0.2)
	get_parent().get_node("Shop").screen_in()

func set_sound_texture():
	if SettingsManager._settings["audio"]["sounds_on"]:
		$Panel/VBoxContainer/SoundButton/icon.texture = sound_on_texture
	else:
		$Panel/VBoxContainer/SoundButton/icon.texture = sound_off_texture

func set_vibration_texture():
	if SettingsManager._settings["display"]["vibration"]:
		$Panel/VBoxContainer/VibrateButton/icon.texture = vibrate_on_texture
	else:
		$Panel/VBoxContainer/VibrateButton/icon.texture = vibrate_off_texture

func _on_SoundButton_pressed():
	SettingsManager._settings["audio"]["sounds_on"] = not SettingsManager._settings["audio"]["sounds_on"]
	SettingsManager.save_settings()
	set_sound_texture()
	


func _on_VibrateButton_pressed():
	SettingsManager._settings["display"]["vibration"] = not SettingsManager._settings["display"]["vibration"]
	SettingsManager.save_settings()
	set_vibration_texture()
