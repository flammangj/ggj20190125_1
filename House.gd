extends Spatial

var room_matrix = Vector3(3,3,3)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("house ready?")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_rooms():
	var rooms = []
	for child in get_children():
		if child.is_in_group("rooms"):
			rooms.append(child)
	return rooms

func get_active_room():
	for room in get_rooms():
		if room.active:
			return room
	return null

func get_active_room_row(direction):
	var active = get_active_room()
	print("active", active)
	if not active:
		return null
	var pos = 'z'
	if direction:
		pos = 'x'
	var activePos = active.matrixPos
	
	
	var rooms = []
	print("pos", pos)
	for room in get_rooms():
		print("poses", room.matrixPos, activePos)
		if room.matrixPos[pos] == activePos[pos]:
			print("true")
			rooms.append(room)
		else:
			print("false")
	return rooms
	print("rooms", rooms)
	

func turn_scene(direction):
	var row = get_active_room_row(direction)
	print("row", row)
	if not row:
		return
	for room in get_rooms():
		room.visible = true
		if not row.has(room):
			room.visible = false
	
	