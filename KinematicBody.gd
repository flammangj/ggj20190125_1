extends KinematicBody

var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.current = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	velocity = process_user_movement()
	move_and_slide(velocity)


func process_user_movement():
	var velocity = Vector3()
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			velocity.x += 1
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		pass
		
	return velocity