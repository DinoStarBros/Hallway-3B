extends StaticBody2D

@onready var anim: AnimationPlayer = %anim

var in_range : bool = false
var opened : bool = false

func open() -> void:
	anim.play("open")
	opened = true
	%open.play(0.45)

func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body is Player and not opened:
		in_range = true
		anim.play("highlight")

func _on_trigger_area_body_exited(body: Node2D) -> void:
	if body is Player and not opened:
		in_range = false
		anim.play_backwards("highlight")

func _unhandled_input(_event: InputEvent) -> void:
	if in_range and not opened:
		if Input.is_action_just_pressed("M1"):
			open()
