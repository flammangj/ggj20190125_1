extends Spatial

export (Vector3) var matrixPos = Vector3()

export (bool) var active = false
var active_light_energy = 1.0
var dropped = false

var translation_speed = 6000
var rotation_speed = 1

var target_translation = Vector3(0,0,0)
var low_translate = 1
var high_translate = 0
var translating = false

class_name Room

func _ready():
	$RoomDetectionArea.connect("body_entered", self, "_on_Area_body_entered")
	$RoomDetectionArea.connect("body_exited", self, "_on_Area_body_exited")
	var overlapped_bodies = $RoomDetectionArea.get_overlapping_bodies()
	for body in overlapped_bodies:
		if body.is_in_group("player"):
			active = true
	
func _physics_process(delta):
	if translating:
		if dropped:
			print("down")
		else:
			print("up")

		translation += target_translation / (translation_speed * delta)
#		translate(target_translation / (translation_speed * delta))

		if not dropped and translation[1] >= high_translate:
			translating = false
			translation = target_translation
			
		if dropped and translation[1] <= low_translate:
			translating = false
			translation = target_translation
		
	

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		clear_all_rooms_active()
		active = true
		body.current_room = self
		# REENABLE TO DEBUG
#		$RoomActiveLight.visible = true 
	pass # Replace with function body.

func clear_all_rooms_active():
	var rooms = get_parent().get_children()
	for room in rooms:
		$RoomActiveLight.visible = false
		if room.is_in_group("rooms"):
			room.active = false


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		active = false
		$RoomActiveLight.visible = false
	pass # Replace with function body.

func is_active():
	return active
	
func falldown():
	dropped = !dropped
	translating = true
	if dropped:
		target_translation = (Vector3(0, -1, 0))
	else:
		target_translation = Vector3()
	