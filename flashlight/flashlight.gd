extends Node2D

func _ready() -> void:
	show()

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	for n in %light_area.get_overlapping_bodies():
		if n is Look:
			n.health -= delta
			n.shake(delta)
