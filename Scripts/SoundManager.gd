extends Node


var possible_sounds = {
	"slide" : preload("res://Sounds/slide.wav"),
	"win" : preload("res://Sounds/win.wav"),
	"confetti" : preload("res://Sounds/confetti.wav"),
}

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


func play_fixed_sound(sound_name : String, volume : int = 0, pitch_scale : float = 1.0 ):
	# Creates a new instance for each sound in order to 
	# avoid playing single sound at the same time.
	if SettingsManager._settings["audio"]["sounds_on"]:
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = possible_sounds[sound_name]
		audio_player.volume_db = volume
		audio_player.pitch_scale = pitch_scale
		add_child(audio_player)
		audio_player.play()
		var err = audio_player.connect("finished", self,"_on_sound_finished", [audio_player])
		if err != OK:
			print("There is something wrong with connection of the signal in SoundManager/ play_fixed_sound()")

func stop_fixed_sound(sound_name : String):
	for node in get_children():
		if node.stream == possible_sounds[sound_name]:
			_on_sound_finished(node)

func _on_sound_finished(obj):
	if obj.is_inside_tree():
		remove_child(obj)
