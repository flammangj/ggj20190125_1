extends StaticBody

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		active = true
		print ("nice")
	pass # Replace with function body.


func _on_Area_body_exited(body):
	print("body visited")
	if body.is_in_group("player"):
		active = false
		print ("ok goodbye")
	pass # Replace with function body.

func is_active():
	return active