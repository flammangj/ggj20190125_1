extends Sprite3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 0.1
var moveaway = false
var counter = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Vector3(1,0,0)
	if moveaway:
		counter-= 1
		print(counter)
		global_translate(direction*speed*delta)
		if counter < 0:
			self.queue_free()

func move_away():
	show()
	moveaway = true