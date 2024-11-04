extends Node
class_name StateMachine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func change_state(source_state : State, new_state_name : String):
	# Check if transitioning from the correct state
	if source_state != current_state:
		print("Invalid change_state trying from: " + source_state.name + " but current is " + current_state.name)
		return
	
	# Check if new state actually exists in the dictionary
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
