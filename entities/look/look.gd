extends CharacterBody2D
class_name Look

var player_pos : Vector2
var random_offset_position : Vector2
var glued_to_x : bool
var udlr : bool
var health : float = 3

const offset_range : Vector2 = Vector2(700, 400)

func _ready() -> void:
	randomize_offset_position()
	health += randf_range(-0.5, 1)

func _process(_delta: float) -> void:
	player_pos = Global.player.global_position
	
	Global.cam.screen_shake(15, 0.1)
	global_position = player_pos + random_offset_position
	
	if health >= 2:
		%eye.frame = 0
	elif health < 2 and health > 1:
		%eye.frame = 1
	else:
		%eye.frame = 2
	
	if health <= 0:
		queue_free()

func randomize_offset_position() -> void:
	glued_to_x = randi_range(1,2) == 1
	udlr = randi_range(1,2) == 1
	
	if glued_to_x: 
		
		random_offset_position.y = randi_range(
			-offset_range.y,
			offset_range.y
		)
		if udlr:
			random_offset_position.x = offset_range.x
		else:
			random_offset_position.x = -offset_range.x
		
	else:
		
		random_offset_position.x = randf_range(
			-offset_range.x,
			offset_range.x
		)
		if udlr:
			random_offset_position.y = offset_range.y
		else:
			random_offset_position.y = -offset_range.y

func _on_position_timer_timeout() -> void:
	randomize_offset_position()

func shake(delta: float) -> void:
	%shakeAnim.play("shake")

func _on_jumpscare_timer_timeout() -> void:
	
	GlobalSignals.Jumpscared.emit()
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.game_state = Global.game_states.Lost
	get_tree().paused = true
	
	%glitchy.stop()
	%spawn_sound.stop()
	
	await get_tree().create_timer(0.2).timeout
	
	%shakeAnim.play("jumpscare")
	
	await get_tree().create_timer(2).timeout
	
	Global.game_over()
