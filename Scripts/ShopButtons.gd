extends HBoxContainer

enum {BOX, THEME, ADD}

var current_screen  = BOX setget current_screen_set, current_screen_get

export (Color) var normal_color 
export (Color) var pressed_color 

onready var title = get_node("../TopUI/Title")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func current_screen_set(value):
	if value == BOX:
		current_screen = value
		title.text = "BOX"
		get_node("../BOXContent").visible = true
		get_node("../THEMEContent").visible = false
		get_node("../ADDContent").visible = false
		print("BOX SCREEN")
	elif value == THEME:
		current_screen = value
		title.text = "THEME"
		get_node("../BOXContent").visible = false
		get_node("../THEMEContent").visible = true
		get_node("../ADDContent").visible = false
		print("THEME SCREEN")
	elif value == ADD:
		current_screen = value
		title.text = "ADD"
		get_node("../BOXContent").visible = false
		get_node("../THEMEContent").visible = false
		get_node("../ADDContent").visible = true
		print("ADD SCREEN")
	else:
		print("Undfined value for current_screen")
		return
		

func current_screen_get():
	return current_screen

func _on_Button2_pressed():
	# local access will not trigger the setter and getter, to be trigger use with self
	self.current_screen = THEME
	$Button2/icon.modulate = pressed_color
	$Button/icon.modulate = normal_color
	$Button3/icon.modulate = normal_color
	$Button2.disabled = true
	$Button.disabled = false
	$Button3.disabled = false
	$Button.pressed = false
	$Button3.pressed = false


func _on_Button3_pressed():
	self.current_screen = ADD
	$Button2/icon.modulate = normal_color
	$Button/icon.modulate = normal_color
	$Button3/icon.modulate = pressed_color
	$Button3.disabled = true
	$Button2.disabled = false
	$Button.disabled = false
	$Button2.pressed = false
	$Button.pressed = false


func _on_Button_pressed():
	self.current_screen = BOX
	$Button2/icon.modulate = normal_color
	$Button/icon.modulate = pressed_color
	$Button3/icon.modulate = normal_color
	$Button.disabled = true
	$Button2.disabled = false
	$Button3.disabled = false
	$Button2.pressed = false
	$Button3.pressed = false


