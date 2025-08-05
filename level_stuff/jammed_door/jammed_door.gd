extends StaticBody2D

@onready var anim: AnimationPlayer = %anim

var player : Player
var opened : bool = false
var velocity : Vector2
var dir_to_player : Vector2
var enable_gravity : bool = false

func open() -> void:
	anim.play("open")
	opened = true
	velocity.x = -dir_to_player.x * 1000
	velocity.y = - 600
	enable_gravity = true
	%knockDownDoor.pitch_scale += randf_range(-0.1, 0.1)
	%knockDownDoor.play(0.05)
	
	%knockDownDoor2.pitch_scale += randf_range(-0.1, 0.1)
	%knockDownDoor2.play()
	
	%lifeTimer.start(2)
	
	%Hitspark.look_at(player.global_position)
	
	Global.cam.screen_shake(5, 0.2)
	Global.frame_freeze(0.1, 0.1)

func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body is Player and not opened:
		player = body
		anim.play("highlight")

func _on_trigger_area_body_exited(body: Node2D) -> void:
	if body is Player and not opened:
		player = null
		anim.play_backwards("highlight")

func _physics_process(delta: float) -> void:
	move(delta)
	if enable_gravity:
		velocity.y += Global.gravity * delta
	
	if player and not opened:
		if player.sm.current_state.name == "slide" or player.sm.current_state.name == "dive" or player.sm.current_state.name == "run":
			open()
			dir_to_player = global_position.direction_to(player.global_position)
			velocity.x = -dir_to_player.x * 1000 

func move(delta:float) -> void:
	global_position += velocity * delta

func _on_life_timer_timeout() -> void:
	queue_free()
