extends RigidBody

var velocity
export (int) var SPEED = 40

export (bool) var perspective = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.current = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	velocity = process_user_movement()
	add_central_force(velocity*SPEED)


func process_user_movement():
	var velocity = Vector3()
	var axis = 'x'
	if perspective:
		axis = 'z'
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			velocity[axis] += 1
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity[axis] -= 1
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		pass
		
	return velocity
	
func switch_perspective(direction: bool):
	if perspective == direction:
		return
	perspective = direction
	if perspective:
		rotate_y(deg2rad(-90))

	