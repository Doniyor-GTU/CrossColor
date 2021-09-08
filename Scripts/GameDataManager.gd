extends Node

var default_game_data

# unlocked_square_textures will be saved by its product code
# unlocked_background_textures will be saved by its product code
var game_data = {
	"level" : 0,
	"coins" : 100,
	"unlocked_square_textures" : [0],
	"unlocked_background_textures" : [0],
	"is_add_active" : true,
	"get_coin_time" : {"is_stoped" : true, "min" : 0, "sec" : 0}
#	"is_add_active" : true
}

func _ready():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		save_game()
#	else:
#		var saved_data = load_game()
#		refresh_data(game_data, saved_data)
	game_data = load_game()

func refresh_data(new_data, old_data):
	# if app is developed and in new version has new data
	# it will be updated
	var is_refreshed = false
	for key in new_data.keys():
		if not old_data.has(key):
			old_data[key] = new_data[key]
			is_refreshed = true
	if is_refreshed:
		print("refreshed and saved")
		save_game(old_data)

func save_game(data = game_data):
	var save_game = File.new()
	var err = save_game.open("user://savegame.save", File.WRITE)
	if err != OK:
		print("something went wrong!")
		return
	save_game.store_line(to_json(data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		print("SaveGame file not found")
		return default_game_data
	save_game.open("user://savegame.save", File.READ)
	var data = parse_json(save_game.get_line())
	return data
