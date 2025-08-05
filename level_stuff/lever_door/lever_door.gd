extends StaticBody2D

@onready var anim: AnimationPlayer = %anim

var in_range : bool = false
var opened : bool = false

var levers : Array[Lever]
var levers_flicked : Array[bool]

func _ready() -> void:
	for child in get_children():
		if child is Lever:
			levers.append(child)

func open() -> void:
	if not opened:
		anim.play("open")
		opened = true
		%open.play(0.45)

func _process(_delta: float) -> void:
	levers_flipped_check()

func levers_flipped_check() -> void:
	for lever in levers:
		levers_flicked.append(lever.flicked)
	
	if levers_flicked.count(true) == levers.size():
		open()
	
	levers_flicked.clear()
