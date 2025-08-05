extends Node
class_name StateMachinePlayer

@export var initial_state : String

var current_state : StatePlr
var previous_state : StatePlr

func _ready()-> void:
	current_state = find_child(initial_state) as StatePlr
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	%sm_text.text = str(current_state.name)
	pass

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StatePlr
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
