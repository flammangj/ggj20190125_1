extends Spatial

var game_running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_running = true
	$AmbienteMusic.play()
	turn_scene(false)
	$Sequencer.proceed()
	pass # Replace with function body.

func proceed():
	$Sequencer.proceed()
	
func _input(event):
	if event.is_action_pressed("perspective_left") and game_running:
		turn_scene(true)
		get_tree().set_input_as_handled()
	if event.is_action_pressed("perspective_right") and game_running:
		turn_scene(false)
		get_tree().set_input_as_handled()
		
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
	
func turn_scene(direction):
	$House/Player.switch_perspective(direction)
	$House.turn_scene(direction)
	

func restart_player():
	turn_scene(false)
	$House/Player.global_transform = $House/Room021.global_transform

func _on_Sequencer_sequence_done(step):
	print("step received", step)
	if step == 1:
		pass
	if step == 2:
		print("dothing")
		proceed()
	if step == 3:
		proceed()
	if step == 4:
		$House/dad.move_away()
		$House/Room121/Door.close()
		$House/Room121/Door.lock()
		
	if step == 6:
		get_tree().quit()

		
	pass # Replace with function body.
	
func game_over():
	$Sequencer.step = 5
	proceed()
