extends Node

signal square_texture_changed
signal background_texture_changed

var Home = preload("res://Scene/MainScreen.tscn")

var levels = {
	"0": preload("res://Scene/Levels/Level_0.tscn"),
	"1": preload("res://Scene/Levels/Level_1.tscn"),
	"2": preload("res://Scene/Levels/Level_2.tscn"),
	"3": preload("res://Scene/Levels/Level_3.tscn"),
	"4": preload("res://Scene/Levels/Level_4.tscn"),
	"5": preload("res://Scene/Levels/Level_5.tscn"),
	"6": preload("res://Scene/Levels/Level_6.tscn"),
	"7": preload("res://Scene/Levels/Level_7.tscn"),
	"8": preload("res://Scene/Levels/Level_8.tscn"),
	"9": preload("res://Scene/Levels/Level_9.tscn"),
	"10": preload("res://Scene/Levels/Level_10.tscn"),
	"11": preload("res://Scene/Levels/Level_11.tscn"),
	"12": preload("res://Scene/Levels/Level_12.tscn"),
	"13": preload("res://Scene/Levels/Level_13.tscn"),
	"14": preload("res://Scene/Levels/Level_14.tscn"),
	"15": preload("res://Scene/Levels/Level_15.tscn"),
	"16": preload("res://Scene/Levels/Level_16.tscn"),
	"17": preload("res://Scene/Levels/Level_17.tscn"),
	"18": preload("res://Scene/Levels/Level_18.tscn"),
	"19": preload("res://Scene/Levels/Level_19.tscn"),
	"20": preload("res://Scene/Levels/Level_20.tscn"),
	"21": preload("res://Scene/Levels/Level_21.tscn"),
	"22": preload("res://Scene/Levels/Level_22.tscn"),
	"23": preload("res://Scene/Levels/Level_23.tscn"),
	"24": preload("res://Scene/Levels/Level_24.tscn"),
	"25": preload("res://Scene/Levels/Level_25.tscn"),
	"26": preload("res://Scene/Levels/Level_26.tscn"),
	"27": preload("res://Scene/Levels/Level_27.tscn"),
	"28": preload("res://Scene/Levels/Level_28.tscn"),
	"29": preload("res://Scene/Levels/Level_29.tscn"),
	"30": preload("res://Scene/Levels/Level_30.tscn"),
	"31": preload("res://Scene/Levels/Level_31.tscn"),
	"32": preload("res://Scene/Levels/Level_32.tscn"),
	"33": preload("res://Scene/Levels/Level_33.tscn"),
	"34": preload("res://Scene/Levels/Level_34.tscn"),
	"35": preload("res://Scene/Levels/Level_35.tscn"),
	"36": preload("res://Scene/Levels/Level_36.tscn"),
	"37": preload("res://Scene/Levels/Level_37.tscn"),
	"38": preload("res://Scene/Levels/Level_38.tscn"),
	"39": preload("res://Scene/Levels/Level_39.tscn"),
	"40": preload("res://Scene/Levels/Level_40.tscn"),
	"41": preload("res://Scene/Levels/Level_41.tscn"),
	"42": preload("res://Scene/Levels/Level_42.tscn"),
	"43": preload("res://Scene/Levels/Level_43.tscn"),
	"44": preload("res://Scene/Levels/Level_44.tscn"),
	"45": preload("res://Scene/Levels/Level_45.tscn"),
	"46": preload("res://Scene/Levels/Level_46.tscn"),
	"47": preload("res://Scene/Levels/Level_47.tscn"),
	"48": preload("res://Scene/Levels/Level_48.tscn"),
	"49": preload("res://Scene/Levels/Level_49.tscn"),
	"50": preload("res://Scene/Levels/Level_50.tscn"),
	"51": preload("res://Scene/Levels/Level_51.tscn"),
	"52": preload("res://Scene/Levels/Level_52.tscn"),
	"53": preload("res://Scene/Levels/Level_53.tscn"),
	"54": preload("res://Scene/Levels/Level_54.tscn"),
	"55": preload("res://Scene/Levels/Level_55.tscn"),
	"56": preload("res://Scene/Levels/Level_56.tscn"),
	"57": preload("res://Scene/Levels/Level_57.tscn"),
	"58": preload("res://Scene/Levels/Level_58.tscn"),
	"59": preload("res://Scene/Levels/Level_59.tscn"),
	"60": preload("res://Scene/Levels/Level_60.tscn"),
	"61": preload("res://Scene/Levels/Level_61.tscn"),
	"62": preload("res://Scene/Levels/Level_62.tscn"),
	"63": preload("res://Scene/Levels/Level_63.tscn"),
	"64": preload("res://Scene/Levels/Level_64.tscn"),
	"65": preload("res://Scene/Levels/Level_65.tscn"),
	"66": preload("res://Scene/Levels/Level_66.tscn"),
	"67": preload("res://Scene/Levels/Level_67.tscn"),
	"68": preload("res://Scene/Levels/Level_68.tscn"),
	"69": preload("res://Scene/Levels/Level_69.tscn"),
	"70": preload("res://Scene/Levels/Level_70.tscn"),
	"71": preload("res://Scene/Levels/Level_71.tscn"),
	"72": preload("res://Scene/Levels/Level_72.tscn"),
	"73": preload("res://Scene/Levels/Level_73.tscn"),
	"74": preload("res://Scene/Levels/Level_74.tscn"),
	"75": preload("res://Scene/Levels/Level_75.tscn"),
	"76": preload("res://Scene/Levels/Level_76.tscn"),
	"77": preload("res://Scene/Levels/Level_77.tscn"),
	"78": preload("res://Scene/Levels/Level_78.tscn"),
	"79": preload("res://Scene/Levels/Level_79.tscn"),
	"80": preload("res://Scene/Levels/Level_80.tscn"),
	"81": preload("res://Scene/Levels/Level_81.tscn"),
	"82": preload("res://Scene/Levels/Level_82.tscn"),
	"83": preload("res://Scene/Levels/Level_83.tscn"),
	"84": preload("res://Scene/Levels/Level_84.tscn"),
	"85": preload("res://Scene/Levels/Level_85.tscn"),
	"86": preload("res://Scene/Levels/Level_86.tscn"),
	"87": preload("res://Scene/Levels/Level_87.tscn"),
	"88": preload("res://Scene/Levels/Level_88.tscn"),
	"89": preload("res://Scene/Levels/Level_89.tscn"),
	"90": preload("res://Scene/Levels/Level_90.tscn"),
	"91": preload("res://Scene/Levels/Level_91.tscn"),
	"92": preload("res://Scene/Levels/Level_92.tscn"),
	"93": preload("res://Scene/Levels/Level_93.tscn"),
	"94": preload("res://Scene/Levels/Level_94.tscn"),
	"95": preload("res://Scene/Levels/Level_95.tscn"),
	"96": preload("res://Scene/Levels/Level_96.tscn"),
	"97": preload("res://Scene/Levels/Level_97.tscn"),
	"98": preload("res://Scene/Levels/Level_98.tscn"),
	"99": preload("res://Scene/Levels/Level_99.tscn"),
	"100": preload("res://Scene/Levels/Level_100.tscn"),
}

var background_textures = [
	preload("res://Art/background_textures/background_0.png"),
	preload("res://Art/background_textures/background_1.png"),
	preload("res://Art/background_textures/background_2.png"),
	preload("res://Art/background_textures/background_3.png"),
	preload("res://Art/background_textures/background_4.png"),
	preload("res://Art/background_textures/background_5.png"),
	preload("res://Art/background_textures/background_6.png"),
	preload("res://Art/background_textures/background_7.png"),
	preload("res://Art/background_textures/background_8.png"),
]

var square_textures_0 = [
	preload("res://Art/square_textures/0/box_blue.png"),
	preload("res://Art/square_textures/0/box_red.png"),
	preload("res://Art/square_textures/0/box_yellow.png"),
	preload("res://Art/square_textures/0/box_green.png"),
	preload("res://Art/square_textures/0/box_orange.png"),
	preload("res://Art/square_textures/0/box_purple.png"),
	preload("res://Art/coinIcon.png")
]

var square_textures_1 = [
	preload("res://Art/square_textures/1/rhino.png"),
	preload("res://Art/square_textures/1/monkey.png"),
	preload("res://Art/square_textures/1/chick.png"),
	preload("res://Art/square_textures/1/snake.png"),
	preload("res://Art/square_textures/1/tiger.png"),
	preload("res://Art/square_textures/1/mouse.png"),
	preload("res://Art/coinIcon.png")
]

var square_textures_2 = [
	preload("res://Art/square_textures/2/2.png"),
	preload("res://Art/square_textures/2/0.png"),
	preload("res://Art/square_textures/2/4.png"),
	preload("res://Art/square_textures/2/1.png"),
	preload("res://Art/square_textures/2/3.png"),
	preload("res://Art/square_textures/2/5.png"),
	preload("res://Art/coinIcon.png")
]

var square_textures_3 = [
	preload("res://Art/square_textures/3/1.png"),
	preload("res://Art/square_textures/3/5.png"),
	preload("res://Art/square_textures/3/3.png"),
	preload("res://Art/square_textures/3/2.png"),
	preload("res://Art/square_textures/3/6.png"),
	preload("res://Art/square_textures/3/4.png"),
	preload("res://Art/coinIcon.png")
]

var square_textures_4 = [
	preload("res://Art/square_textures/4/3.png"),
	preload("res://Art/square_textures/4/2.png"),
	preload("res://Art/square_textures/4/4.png"),
	preload("res://Art/square_textures/4/6.png"),
	preload("res://Art/square_textures/4/5.png"),
	preload("res://Art/square_textures/4/1.png"),
	preload("res://Art/coinIcon3.png")
]

var square_textures_5 = [
	preload("res://Art/square_textures/5/4.png"),
	preload("res://Art/square_textures/5/2.png"),
	preload("res://Art/square_textures/5/6.png"),
	preload("res://Art/square_textures/5/5.png"),
	preload("res://Art/square_textures/5/3.png"),
	preload("res://Art/square_textures/5/1.png"),
	preload("res://Art/coinIcon3.png")
]

var square_texture_code = 0 setget set_square_textures, get_square_textures
var background_texture_code = 0 setget set_background_texture, get_background_texture
var square_textures = square_textures_0 
var background_texture = background_textures[0]

func _ready():
	self.background_texture_code = SettingsManager._settings["display"]["background_texture"]
	self.square_texture_code = SettingsManager._settings["display"]["square_texture"]

func set_background_texture(value):
	if (value >= 0) and (value < background_textures.size()):
		background_texture_code = value
		background_texture = background_textures[value]
		emit_signal("background_texture_changed")
	else:
		background_texture_code = 0
		background_texture = background_textures[0]
		emit_signal("background_texture_changed")

func get_background_texture():
	return background_texture_code

func set_square_textures(value):
	if value == 0:
		square_texture_code = 0
		square_textures = square_textures_0
		emit_signal("square_texture_changed")
	elif value == 1:
		square_texture_code = 1
		square_textures = square_textures_1
		emit_signal("square_texture_changed")
	elif value == 2:
		square_texture_code = 2
		square_textures = square_textures_2
		emit_signal("square_texture_changed")
	elif value == 3:
		square_texture_code = 3
		square_textures = square_textures_3
		emit_signal("square_texture_changed")
	elif value == 4:
		square_texture_code = 4
		square_textures = square_textures_4
		emit_signal("square_texture_changed")
	elif value == 5:
		square_texture_code = 5
		square_textures = square_textures_5
		emit_signal("square_texture_changed")
	else:
		square_texture_code = 0
		square_textures = square_textures_0
		emit_signal("square_texture_changed")
		print("Other texture cant be loaded, something went wrong!")


func get_square_textures():
	return square_texture_code
