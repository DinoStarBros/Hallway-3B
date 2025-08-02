extends Node
class_name StatePlr

@onready var p : Player = owner

func _ready()-> void:
	exit()

func enter()-> void:
	on_enter()
	set_physics_process(true)

func exit()-> void:
	on_exit()
	set_physics_process(false)

func on_enter()-> void:
	pass

func on_exit()-> void:
	pass

func _physics_process(delta:float)-> void:
	process(delta)

func process(_delta:float)-> void:
	pass
