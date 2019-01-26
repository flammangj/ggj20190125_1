extends StaticBody

var active = false
var active_light_energy = 0.1

# Called when the node enters the scene tree for the first time.
func _init():
	print("READY?")
	print(get_children())
	$RoomDetectionArea/CollisionShape.connect("body_entered", self, "_on_Area_body_entered")
	$RoomDetectionArea/CollisionShape.connect("body_exited", self, "_on_Area_body_exited")
	pass # Replace with function body.

func _on_Area_body_entered(body):
	print("body", body)
	if body.is_in_group("player"):
		clear_all_rooms_active()
		active = true
		$RoomActiveLight.light_energy = active_light_energy
		print ("nice")
	pass # Replace with function body.

func clear_all_rooms_active():
	var rooms = get_parent().get_children()
	for room in rooms:
		if room.is_in_group("rooms"):
			room.active = false
			$RoomActiveLight.light_energy = 0

func _on_Area_body_exited(body):
	print("body visited")
	if body.is_in_group("player"):
		active = false
		$RoomA
		print ("ok goodbye")
	pass # Replace with function body.

func is_active():
	return active