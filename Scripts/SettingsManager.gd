extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"sounds_on": true
	},
	"display": {
		"background_texture": 0,
		"square_texture" : 0,
		"vibration" : true
	}
}

var _is_rewarded_video_loaded = false
var _is_interstitial_loaded = false

func _ready():
	load_settings()
	#TranslationServer.set_locale(_settings["other"]["language"])
	
func save_settings():
	#TranslationServer.set_locale(_settings["other"]["language"])
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	var error = _config_file.save(SAVE_PATH)
	if error != OK:
		print("Settings file not saved. Error code %s" % error)
		return null
	
func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		if error == 7:
			save_settings()
		else:
			print("Failed loading settings file. Error code %s" % error)
			return null
	for section in _settings.keys():
		for key in _settings[section].keys():
			var val = _settings[section][key]
			_settings[section][key] = _config_file.get_value(section, key, val)
			
