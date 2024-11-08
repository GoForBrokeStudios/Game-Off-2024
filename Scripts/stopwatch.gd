extends Node2D
class_name Stopwatch

var time : float = 0.0
var stopped : bool = false

func _process(delta):
	if stopped:
		return
	
	time += delta

func reset():
	time = 0.0
	
func time_to_string() -> String:
	# Turns the time var into a string for UI display
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60.0
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string
