extends GridContainer

onready var root_node = get_node("../../..")
onready var coins_label = get_node("../../TopUI/Coins")

var unlocked_square_textures = [0]
var selected_texture = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	unlocked_square_textures = GameDataManager.game_data["unlocked_square_textures"]
	selected_texture = SettingsManager._settings["display"]["square_texture"]
	set_unlocked_square_texture()


func set_unlocked_square_texture():
	for node in get_children():
		if node.product_code in unlocked_square_textures:
			node.is_active = true
		else:
			node.is_active = false
		if node.product_code == selected_texture:
			node.is_selected = true

func unselect_product_button():
	# Unselects the selected ProductButton
	for node in get_children():
		if node.is_selected:
			node.is_selected = false

func select_product_button(object):
	selected_texture = object.product_code
	SettingsManager._settings["display"]["square_texture"] = selected_texture
	LoadedScreens.square_texture_code = selected_texture
	SettingsManager.save_settings()

func unlock_texture(object):
	unlocked_square_textures.append(object.product_code)
	GameDataManager.game_data["unlocked_square_textures"] = unlocked_square_textures
	GameDataManager.save_game()

func _on_ProductButton6_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_ProductButton_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_ProductButton2_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_ProductButton3_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_ProductButton4_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_ProductButton5_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true





func _on_ProductButton6_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_ProductButton_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_ProductButton2_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_ProductButton3_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_ProductButton4_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_ProductButton5_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true
