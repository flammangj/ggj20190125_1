extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal sequence_done(step)

var step = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show():
	$Control.show()
	
func hide():
	$Control.hide()

func proceed():
	step += 1
	
	if step == 1:
		show()
		$Control/Seq_1.show()
		$Timer.wait_time = 2
		$Timer.start()
		yield($Timer, "timeout")
		$Control/Seq_2.show()
		hide_after_t(3)

	if step == 2:
		show()
		get_parent().restart_player()
		$Control/Seq_1.hide()
		$Control/Seq_2.hide()
		$Control/Seq_3.show()
		hide_after_t(3)
		
	if step == 3:
		show()
		$Control/Seq_3.hide()
		$Control/Seq_5.show()
		hide_after_t(3)
	if step == 4:
		$Control/Seq_5.hide()
		$Control/Seq_6.show()
		hide_after_t(3)
	if step == 5:
		$Control/Seq_6.hide()
		$Control/Seq_7.show()
		hide_after_t(3)
	if step == 6:
		$Control/Seq_7.hide()
		$Control/Seq_8.show()
		hide_after_t(3)
		
func hide_after_t(time):
	$Timer.wait_time = time
	$Timer.start()
	yield($Timer, "timeout")
	hide()
	emit_signal("sequence_done", step)