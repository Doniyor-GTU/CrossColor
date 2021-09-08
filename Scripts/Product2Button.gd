extends Button

signal buy_button_pressed(this_btn)
signal button_pressed(this_btn)

export (int) var product_code = 0
export (int) var price = 1000
export (Texture) var bg_texture


var is_active  = false setget set_active, get_active
var is_selected = false setget set_selected, get_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	if (bg_texture != null):
		get("custom_styles/normal").texture = bg_texture
		get("custom_styles/hover").texture = bg_texture
		get("custom_styles/pressed").texture = bg_texture
	$InActiveIcon/Button/MarginContainer/price.text = str(price)

func set_active(value):
	if value :
		is_active = true
		$InActiveIcon.visible = false
	else:
		is_active = false
		self.is_selected = false
		$InActiveIcon.visible = true

func get_active():
	return is_active

func set_selected(value):
	if value and is_active:
		is_selected = true
		$SelectedIcon.visible = true
	else:
		is_selected = false
		$SelectedIcon.visible = false

func get_selected():
	return is_selected



func _on_Button_pressed():
	emit_signal("buy_button_pressed", self)


func _on_ProductButton_pressed():
	emit_signal("button_pressed", self)
