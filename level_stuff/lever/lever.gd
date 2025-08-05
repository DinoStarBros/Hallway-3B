extends Area2D
class_name Lever

var player_in_range : bool = false
var flicked : bool = false

func _process(_delta: float) -> void:
	if player_in_range:
		if Input.is_action_just_pressed("M1"):
			flick_lever()

func flick_lever() -> void:
	%anim.play("flick")
	flicked = true
	%flick.play(0.05)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
