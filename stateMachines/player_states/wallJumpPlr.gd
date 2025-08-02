extends StatePlr

func on_enter()-> void:
	p.velocity.y = -p.jump_velocity
	p.velocity.x = -p.wall_direction * 400
	p.allow_sprite_flip = false
	%wJTimer.start(0.15)

func process(delta: float)-> void:
	p.sprite.flip_h = p.wall_direction == 1
	
	if p.velocity.y >= 0:
		p.sm.change_state("fallrun")
	
	if p.is_on_floor():
		p.sm.change_state("walk")
	
	if not Input.is_action_pressed("Jump"):
		p.velocity.y *= 0.3

func on_exit()-> void:
	p.allow_sprite_flip = true

func _on_w_j_timer_timeout() -> void:
	p.sm.change_state("fall")

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.walk_speed, p.velocity_weight)
