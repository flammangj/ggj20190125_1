extends KinematicBody

var velocity
export (float) var SPEED = 0.01

export (bool) var perspective = false

var rotation_speed = 1000
var target_rotation = Vector3()
var rotating = false
var current_room = null
var ducked = false
var scaled_down = false
var scaled_up = true

var value = 0
var foot_sfx_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.current = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	velocity = process_user_movement()*SPEED
#	velocity = move_and_slide_with_snap(velocity, Vector3(0, -1, 0), Vector3(0, 1, 0))
	velocity = move_and_collide(velocity)

	
func _physics_process(delta):
	var flattener = Vector3(1,0,1)
	transform.origin = transform.origin * flattener
	
	if rotating:
		rotation += target_rotation / (rotation_speed * delta)
		if (perspective and rotation >= target_rotation) or (not perspective and rotation <= target_rotation):
			rotation = target_rotation
			rotating = false
		
		var transf = get_transform()	
		var rot = rotation.linear_interpolate(target_rotation, value)
		value += delta
		transf.origin += rot
		set_transform(transf)
		
	#	rotation = target_rotation * delta	
	if ducked:
		if not scaled_down:
			scaled_down = true
			scaled_up = false
			global_scale(Vector3(1,0.5,1))
			
	else:
		if not scaled_up:
			scaled_up = true
			scaled_down = false
			global_scale(Vector3(1, 2, 1))
			
	


func process_user_movement():
	var velocity = Vector3()
	var direction_modifier = 1
	var axis = 'x'
	if perspective:
		axis = 'z'
		direction_modifier = -1
	
	if Input.is_action_pressed("duck"):
		ducked = true
	else:
		ducked = false
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity[axis] += 1 * direction_modifier

		play_footsteps()
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity[axis] -= 1 * direction_modifier
		play_footsteps()
	
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		pass
	
	setAnimationDirection(velocity)
	return velocity
	
func play_footsteps():
	if not foot_sfx_playing:
		var pitch = rand_range(0.9, 1)
		$Footsteps.pitch_scale = pitch
		$Footsteps.play()
		foot_sfx_playing = true
		
func setAnimationDirection(velocity):
	if ducked:
		$Sprite3D.texture = load("res://kid2.png")
	else:
		$Sprite3D.texture = load("res://kid1.png")

	if velocity.x == 0 && velocity.z == 0:
		pass
	else:
		$Sprite3D.flip_h = velocity.x > 0
	
func set_rotation_target():
	if perspective:
		var rot = Vector3(0, deg2rad(90), 0)
#		rotate_y(deg2rad(90))
#		target_rotation = rot
		rotation = rot
	else:
		var rot = Vector3(0, deg2rad(0), 0)
#		rotate_y(deg2rad(-90))
#		target_rotation = rot
		rotation = rot
	rotating = false
		
func switch_perspective(direction: bool):
	if perspective == direction:
		return
	#put character to room center
	if current_room:
		global_transform = (current_room.global_transform)
#		translate(Vector3(0,0.1,0))
	perspective = direction
	set_rotation_target()
	

	

func _on_Footsteps_finished():
	foot_sfx_playing = false
