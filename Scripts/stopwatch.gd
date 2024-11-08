extends Node2D
class_name Stopwatch

var time : float = 0.0
var stopped : bool = false

func _process(delta):
	if stopped:
		return
	
	time += delta
	
func stop():
	stopped = true
	
func start():
	stopped = false

func reset():
	time = 0.0
	start()
	
func time_to_string() -> String:
	# Turns the time var into a string for UI display
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60.0
	var format_string = "%02d : %02d : %03d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string
