extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var groups = get_groups()
	print(groups)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func open():
	self.hide()
	$StaticBody/CollisionShape2.disabled = true
	$Area/CollisionShape.disabled = true
	
func close():
	self.show()
	$StaticBody/CollisionShape2.disabled = false
	$Area/CollisionShape.disabled = false
	
func lock():
	add_to_group("door_locked")