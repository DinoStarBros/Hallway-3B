extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Esc"):
		Global.scene_change("uid://wjcfuf7h1eud")
		get_tree().paused = false
