extends Button

signal buy_button_pressed(this_btn)
signal button_pressed(this_btn)

export (int) var product_code = 0
export (int) var price = 300
export (Texture) var icon1
export (Texture) var icon2
export (Texture) var icon3
export (Texture) var icon4

var is_active  = false setget set_active, get_active
var is_selected = false setget set_selected, get_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	if (icon1 != null) and (icon2 != null) and (icon3 != null) and (icon4 != null):
		$Panel/icon1.texture = icon1
		$Panel/icon2.texture = icon2
		$Panel/icon3.texture = icon3
		$Panel/icon4.texture = icon4
	$InActiveIcon/Button/MarginContainer/price.text = str(price)

func set_active(value):
	if value :
		is_active = true
		#self.is_selected = true
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
