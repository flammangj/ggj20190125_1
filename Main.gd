extends Spatial

var game_running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_running = true
#	$AmbienteMusic.play()
	turn_scene(false)
	pass # Replace with function body.

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
	