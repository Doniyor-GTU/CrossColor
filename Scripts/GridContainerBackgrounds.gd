extends GridContainer

onready var root_node = get_node("../../..")
onready var coins_label = get_node("../../TopUI/Coins")


var unlocked_background_textures = [0]
var selected_background = 0

func _ready():
	unlocked_background_textures = GameDataManager.game_data["unlocked_background_textures"]
	selected_background = SettingsManager._settings["display"]["background_texture"]
	set_unlocked_bacground_texture()

func set_unlocked_bacground_texture():
	for node in get_children():
		if node.product_code in unlocked_background_textures:
			node.is_active = true
		else:
			node.is_active = false
		if node.product_code == selected_background:
			node.is_selected = true

func unselect_product_button():
	# Unselects the selected ProductButton
	for node in get_children():
		if node.is_selected:
			node.is_selected = false

func select_product_button(object):
	selected_background = object.product_code
	SettingsManager._settings["display"]["background_texture"] = selected_background
	LoadedScreens.background_texture_code = selected_background
	SettingsManager.save_settings()

func unlock_texture(object):
	unlocked_background_textures.append(object.product_code)
	GameDataManager.game_data["unlocked_background_textures"] = unlocked_background_textures
	GameDataManager.save_game()

func _on_Product2Button_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button2_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button3_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button4_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button5_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button6_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true


func _on_Product2Button7_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true

func _on_Product2Button8_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true

func _on_Product2Button9_button_pressed(this_btn):
	unselect_product_button()
	select_product_button(this_btn)
	root_node.screen_out()
	this_btn.is_selected = true




func _on_Product2Button_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button2_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button3_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button4_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button5_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button6_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button7_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button8_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true


func _on_Product2Button9_buy_button_pressed(this_btn):
	var coins = GameDataManager.game_data["coins"]
	if coins >= this_btn.price:
		GameDataManager.game_data["coins"] = coins - this_btn.price
		GameDataManager.save_game()
		coins_label.text = str(coins - this_btn.price)
		unlock_texture(this_btn)
		this_btn.is_active = true

