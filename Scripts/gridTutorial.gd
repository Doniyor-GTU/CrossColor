extends Node2D

signal swiped
signal firework_added
signal win
signal game_started
signal sort_btn_tutorial_completed

export (int) var n_x_n
export (int) var x_start
export (int) var y_start
export (int) var y_start_top_margin = 0
export (int) var offset
export (int) var gap_between_boxes
export (Array, Array) var level_pattern
export (int) var box_size = 64
export (int) var shuffle_amount = 100

var is_tutorial_end = false
var is_sort_btn_tutorial_end = false
var swipe_order = 0
var swipe_point = Vector2(2,2)
var swipe_direction = Vector2(0,1)

var rnd = RandomNumberGenerator.new()

var directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
var box_path = preload("res://Scene/box.tscn")
var firework_effect_path = preload("res://Scene/Firework3.tscn")
var left_firework_effect_path = preload("res://Scene/Firework_left.tscn")
var right_firework_effect_path = preload("res://Scene/Firework_right.tscn")
var grid_array = []
var temp_grid_array = []
var coins_array = []
onready var menu_btn = get_node("../ColorRect/TopUi/MenuButton")
var gained_coin_lebel = preload("res://Scene/ScoreLabel.tscn")
var next_level_timer = 1.5
var firework_node

var is_started = false
var is_shuffling = false
var is_win = false
var is_temp_grid_array_empty = true


# screen size
onready var screen_size_x = get_viewport_rect().size.x
onready var screen_size_y = get_viewport_rect().size.y
var sort_btn_pos = Vector2(0,0)

func _ready():
	rnd.randomize()
	set_grid()
	LoadedScreens.connect("square_texture_changed", self, "on_square_texture_changed")
	LoadedScreens.connect("background_texture_changed", self, "on_background_texture_changed")
	
func set_grid():
	set_pos(n_x_n)
	grid_array = generate_2d_array(n_x_n, n_x_n)
	temp_grid_array = generate_2d_array(n_x_n, n_x_n)
	on_background_texture_changed()
	spawn_boxes()
	set_coins_array()
	set_sort_btn_pos(n_x_n)
	get_parent().PressToStart_position = Vector2(6, sort_btn_pos.y + $SortButton.rect_size.y/2)
	
#
#func set_pos(size : int):
#	#x_start = (screen_size_x - n_x_n*(box_size+gap_between_boxes)) / 2
#	x_start = (screen_size_x - (size*(box_size) + (size-1)*gap_between_boxes)) / 2
#	y_start = (screen_size_y - size*(box_size+gap_between_boxes)) / 2 

func set_pos(size : int):
	#x_start = (screen_size_x - n_x_n*(box_size+gap_between_boxes)) / 2
	x_start = (screen_size_x - (size*(box_size) + (size-1)*gap_between_boxes)) / 2
	y_start = (screen_size_y - size*(box_size+gap_between_boxes)) / 2 - 50 + y_start_top_margin
	

func set_sort_btn_pos(size : int):
	# 100 ADD space
	var x_pos = screen_size_x/2 - $SortButton.rect_size.x/2
	var y_calculation = (screen_size_y - (grid_array[n_x_n-1][0].position.y + grid_array[n_x_n-1][0].get_size().y) - 100)/2 - $SortButton.rect_size.y/2
	var y_pos = grid_array[n_x_n-1][0].position.y + grid_array[n_x_n-1][0].get_size().y + y_calculation
	sort_btn_pos = Vector2(x_pos, y_pos)


func generate_2d_array(m,n):
	var arr = []
	for i in range(m):
		arr.append([])
		for j in n:
			arr[i].append(null)
	return arr

func grid_to_pixel(grid_pos):
	var row = grid_pos.x
	var column = grid_pos.y
	if row == -1:
		row = n_x_n - 1
	if column == -1:
		column = n_x_n - 1
	var new_x = x_start + box_size*column  + column*gap_between_boxes
	var new_y = y_start + box_size*row  + row*gap_between_boxes
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_pos):
	var pos_x = pixel_pos.x
	var pos_y = pixel_pos.y
	var column = (pos_x - x_start)
	var row = (pos_y - y_start)
	if row > 0 and column > 0:
		row = int(row) / (2*offset+gap_between_boxes)
		column = int(column) / (2*offset+gap_between_boxes)
	return Vector2(row, column)
		
func is_idx_in_grid(row,column):
	if (row >= 0 and row < n_x_n) and (column >= 0 and column < n_x_n):
		return true
	return false

func spawn_boxes(array = grid_array):
	for i in n_x_n:
		for j in n_x_n:
			var box = box_path.instance()
			box.set_texture(LoadedScreens.square_textures[level_pattern[i][j]])
			box.position = grid_to_pixel(Vector2(i,j))
			box.get_node("icon").rect_size = Vector2(box_size, box_size)
			box.texture_code = level_pattern[i][j]
			array[i][j] = box
			$box_container.add_child(box)

func set_current_square_textures():
	for i in n_x_n:
		for j in n_x_n:
			var texture_code = grid_array[i][j].texture_code
			grid_array[i][j].set_texture(LoadedScreens.square_textures[texture_code])

func set_coins_array():
	for i in n_x_n:
		for j in n_x_n:
			if level_pattern[i][j] == -1:
				coins_array.append(grid_array[i][j])
				grid_array[i][j].z_index = 2

func hide_boxes(arr = grid_array):
	if arr.size() > 0:
		for i in arr.size():
			for j in arr.size():
				arr[i][j].visible = false

func show_boxes(arr = grid_array):
	if arr.size() > 0:
		for i in arr.size():
			for j in arr.size():
				arr[i][j].visible = true

func remove_boxes(array):
	for i in n_x_n:
		for j in n_x_n:
			array[i][j].queue_free()

func generate_row(n):
	var row = []
	for i in n:
		row.append(null)
	return row

func is_win():
	for i in n_x_n:
		for j in n_x_n:
			if grid_array[i][j].get_texture() != LoadedScreens.square_textures[level_pattern[i][j]]:
				return false
	is_win = true
	return true


func shuffle_grid_like(data : Dictionary):
	# Shuffles with respect to given data
	# example: data = {0: [Vector2(0,0), Vector2(0,1)], 1: [Vector2(0,0), Vector2(0,-1)]}
	is_started = true
	for key in data.keys():
		swipe_boxes(data[key][1], data[key][0], 0.2)
		yield(get_tree().create_timer(0.2), "timeout")
	if grid_array[n_x_n-1][0].position.y + 200 + $SortButton.rect_size.y/2 < screen_size_y - 100:
		$SortButton.screen_in(Vector2(screen_size_x/2 - $SortButton.rect_size.x/2, grid_array[n_x_n-1][0].position.y + 200))
	else:
		$SortButton.screen_in(Vector2(screen_size_x/2 - $SortButton.rect_size.x/2, grid_array[n_x_n-1][0].position.y + 100))

func shuffle_grid(number_of_shuffles = shuffle_amount):
	is_shuffling = true
	var i = 0
	var random_direction
	var random_grid_pos
	while i < number_of_shuffles:
		i += 1
		random_grid_pos = Vector2(rnd.randi_range(0,n_x_n - 1), rnd.randi_range(0,n_x_n - 1))
		random_direction = directions[rnd.randi_range(0, 3)]
		swipe_boxes(random_direction, random_grid_pos, 0.2)
		yield(get_tree().create_timer(0.1), "timeout")
	if is_win():
		# if matches with an initial shape accidentally, then shuffles again
		print("winnn, shuffling again")
		is_win = false
		shuffle_grid()
	else:
		is_shuffling = false
		sort_btn_screen_in()
		

func sort_btn_screen_in():
	if not $SortButton.visible:
		$SortButton.screen_in(sort_btn_pos)


func swipe_boxes(direction, grid_pos, time = 0.4):
	emit_signal("swiped")
	if direction.y == 0:
		if direction.x < 0:
			var row_idx = grid_pos.x
			var new_row = generate_row(n_x_n)
			for j in range(-1, n_x_n - 1):
				new_row[j+1] = grid_array[row_idx][j]
				#grid_array[row_idx][j].position = grid_to_pixel(Vector2(row_idx, j+1))
				grid_array[row_idx][j].move(grid_array[row_idx][j].position, grid_to_pixel(Vector2(row_idx, j+1)), time)
			grid_array[row_idx] = new_row
		elif direction.x > 0:
			var row_idx = grid_pos.x
			var new_row = generate_row(n_x_n)
			for j in range(0, n_x_n):
				new_row[j-1] = grid_array[row_idx][j]
				#grid_array[row_idx][j].position = grid_to_pixel(Vector2(row_idx, j-1))
				grid_array[row_idx][j].move(grid_array[row_idx][j].position, grid_to_pixel(Vector2(row_idx, j-1)), time)
			grid_array[row_idx] = new_row
	elif direction.x == 0:
		if direction.y < 0:
			var col_idx = grid_pos.y
			var new_row = generate_row(n_x_n)
			for j in range(-1, n_x_n - 1):
				new_row[j+1] = grid_array[j][col_idx]
				#grid_array[j][col_idx].position = grid_to_pixel(Vector2(j+1, col_idx))
				grid_array[j][col_idx].move(grid_array[j][col_idx].position, grid_to_pixel(Vector2(j+1, col_idx)), time)
			for i in n_x_n:
				grid_array[i][col_idx] = new_row[i]
		elif direction.y > 0:
			var col_idx = grid_pos.y
			var new_row = generate_row(n_x_n)
			for j in range(0, n_x_n):
				new_row[j-1] = grid_array[j][col_idx]
				#grid_array[j][col_idx].position = grid_to_pixel(Vector2(j-1, col_idx))
				grid_array[j][col_idx].move(grid_array[j][col_idx].position, grid_to_pixel(Vector2(j-1, col_idx)), time)
			for i in n_x_n:
				grid_array[i][col_idx] = new_row[i]

func zoom_effect():
	$GridAnimation.play("zoom_effect")

func collect_coins():
	if coins_array.size() > 0:
		for i in coins_array.size():
			var pos = coins_array[i].position
			var target = menu_btn.rect_global_position + (menu_btn.rect_size/2)
			coins_array[i].move2(pos, target, 1)

func add_coin_label():
	if coins_array.size() > 0:
		next_level_timer = 2.5
		var coins_amount = 5*coins_array.size()
		var coin_label = gained_coin_lebel.instance()
		coin_label.text = "+" + str(coins_amount)
		coin_label.set_global_position(Vector2(screen_size_x / 2 - coin_label.rect_size.x, y_start - coin_label.rect_size.y - 50))
		get_node("../ColorRect/TopUi").add_child(coin_label)
		GameDataManager.game_data["coins"] = GameDataManager.game_data["coins"] + coins_amount
		GameDataManager.save_game()
		

func add_firewall():
	emit_signal("firework_added")
#	firework_node = firework_effect_path.instance()
#	$box_container.add_child(firework_node)
#	firework_node.position = Vector2(screen_size_x/2, y_start - 100)
#	firework_node.z_index = 10
#	firework_node.play()
	var firework_node_left = left_firework_effect_path.instance()
	var firework_node_right = right_firework_effect_path.instance()
	$box_container.add_child(firework_node_left)
	$box_container.add_child(firework_node_right)
	firework_node_left.position = Vector2(-50, screen_size_y/2)
	firework_node_right.position = Vector2(screen_size_x+50, screen_size_y/2)
	firework_node_left.z_index = 10
	firework_node_right.z_index = 10
	firework_node_left.play()
	firework_node_right.play()



func _input(event):
#	if event.is_action_released("ui_touch") and not is_started:
#		print("pressed")
#		shuffle_grid()
#		is_started = true
#		get_node("../ColorRect/AnimationPlayer").stop()
#		get_node("../ColorRect/Label").visible = false
	pass

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pass

func on_square_texture_changed():
	set_current_square_textures()

func on_background_texture_changed():
	get_parent().get_node("ColorRect/Background").texture = LoadedScreens.background_texture

func _on_SwipeDetector_swiped(direction, start_position):
	if is_sort_btn_tutorial_end :
		var grid_pos = pixel_to_grid(start_position)
		var is_right_swipe_point = false
		if swipe_order == 0 and grid_pos.y == swipe_point.y:
			is_right_swipe_point = true
			is_tutorial_end = false
		elif swipe_order == 1 and grid_pos.x == swipe_point.x:
			is_right_swipe_point = true
			is_tutorial_end = true
		if direction == swipe_direction and is_right_swipe_point:
			swipe_direction = Vector2(1,0)
			swipe_point = Vector2(1,2)
			swipe_order += 1
			$box_container/Hand.stop_animation()
			if not is_tutorial_end:
				$box_container/Hand.global_position = grid_array[1][2].global_position + grid_array[1][2].get_size()/2
				var difference_x = grid_array[1][2].position.x - grid_array[1][1].position.x
				var initial_pos = $box_container/Hand.position
				var target_pos = initial_pos - Vector2(difference_x, 0)
				$box_container/Hand.start_swipe_animation(initial_pos, target_pos, true)
			if is_idx_in_grid(grid_pos.x, grid_pos.y) and is_started and not is_shuffling and not is_win:
				swipe_boxes(direction, pixel_to_grid(start_position))
				if is_win():
					if SettingsManager._settings["display"]["vibration"]:
						Input.vibrate_handheld(250)
					emit_signal("win")
					add_firewall()
					$SortButton.screen_out()
					zoom_effect()
					add_coin_label()
					yield(get_tree().create_timer(0.6), "timeout")
					collect_coins()
					print("You Win")
					yield(get_tree().create_timer(next_level_timer), "timeout")
					var current_level = get_parent().level
					if (str(current_level + 1) in LoadedScreens.levels):
						GameDataManager.game_data["level"] = current_level + 1
						GameDataManager.save_game()
						get_tree().change_scene_to(LoadedScreens.levels[str(current_level+1)])
					
					



func _on_SortButton_button_down():
	if not is_win and not is_shuffling:
		if not $SortButton.is_tutorial_end:
			$SortBtnTimer.start()
		if SettingsManager._settings["display"]["vibration"]:
			Input.vibrate_handheld(25)
		hide_boxes()
		spawn_boxes(temp_grid_array)
		is_temp_grid_array_empty = false


func _on_SortButton_button_up():
	$SortBtnTimer.stop()
	if not is_temp_grid_array_empty:
		remove_boxes(temp_grid_array)
		show_boxes()
		is_temp_grid_array_empty = true


func _on_NextButton_pressed():
	var current_level = get_parent().level
	if (str(current_level + 1) in LoadedScreens.levels):
		GameDataManager.game_data["level"] = current_level + 1
		GameDataManager.save_game()
		get_tree().change_scene_to(LoadedScreens.levels[str(current_level+1)])
	else:
		get_tree().change_scene_to(LoadedScreens.Home)
		


func _on_ShuffleButton_pressed():
	if not is_shuffling and not is_win and is_started:
		shuffle_grid()


func _on_Label_gui_input(event):
	if event.is_action_released("ui_touch") and not is_started:
		print("pressed")
		var shuffle_data = {0:[Vector2(1,1), Vector2(0,1)],
							1:[Vector2(0,1), Vector2(1,0)],
							3:[Vector2(1,1), Vector2(1,0)],
							4:[Vector2(2,1), Vector2(-1,0)],
							2:[Vector2(0,2), Vector2(0,1)],
							5:[Vector2(2,0), Vector2(0,1)],
							6:[Vector2(1,1), Vector2(-1,0)],
							7:[Vector2(0,0), Vector2(0,1)],
							8:[Vector2(1,2), Vector2(0,-1)],
							9:[Vector2(2,2), Vector2(-1,0)],
							10:[Vector2(2,2), Vector2(0,1)],
							11:[Vector2(1,0), Vector2(1,0)],
							12:[Vector2(1,2), Vector2(0,-1)],
							13:[Vector2(0,1), Vector2(0,-1)],
							14:[Vector2(0,2), Vector2(-1,0)],
							15:[Vector2(1,1), Vector2(0,1)]
							}
		#shuffle_grid()
		shuffle_grid_like(shuffle_data)
		is_started = true
		get_node("../ColorRect/AnimationPlayer").stop()
		get_node("../ColorRect/Label").visible = false
		get_node("../ColorRect/TopUi/Label").visible = false


func _on_grid_sort_btn_tutorial_completed():
	get_node("../ColorRect/TopUi/Label2").visible = true
	$box_container/Hand.global_position = grid_array[2][2].global_position + grid_array[2][2].get_size()/2
	var difference_y = grid_array[2][2].position.y - grid_array[1][2].position.y
	var initial_pos = $box_container/Hand.position
	var target_pos = initial_pos - Vector2(0, difference_y)
	print(difference_y, " ", initial_pos)
	$box_container/Hand.start_swipe_animation(initial_pos, target_pos, false)
	is_sort_btn_tutorial_end = true
	$box_container/Hand.visible = true


func _on_SortBtnTimer_timeout():
	if not $SortButton.is_tutorial_end:
		$SortButton.hide_tutorials()
		emit_signal("sort_btn_tutorial_completed")
