extends CharacterBody2D

const speed : int = 3000
var dist_to_plr : float
var nearness_thing : float

func _ready() -> void:
	spawn_fx()

func spawn_fx() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	dist_to_plr = global_position.distance_to(Global.player.global_position)
	
	if dist_to_plr <= 4000:
		Global.cam.screen_shake(10, 0.2)
	elif dist_to_plr <= 2000:
		Global.cam.screen_shake(20, 0.2)
	elif dist_to_plr <= 1000:
		Global.cam.screen_shake(30, 0.2)

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_run_start_timer_timeout() -> void:
	velocity.x = speed

func _on_jumpscare_box_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	GlobalSignals.Jumpscared.emit()
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.game_state = Global.game_states.Lost
	get_tree().paused = true
	velocity.x = 0
	
	for n in %sfx.get_children():
		if n is AudioStreamPlayer2D:
			n.stop()
	
	await get_tree().create_timer(0.2).timeout
	%jumpscare1.pitch_scale += randf_range(-.2,.2)
	%jumpscare1.play(randf_range(5,10))
	%anim.play("tv_static_jumpscare")
	await get_tree().create_timer(2).timeout
	
	Global.game_over()
