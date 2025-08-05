extends StatePlr

func on_enter()-> void:
	p.allow_sprite_flip = false
	%dive.pitch_scale = randf_range(.9,1.1)
	%dive.play()
	

func process(delta: float)-> void:
	p.velocity.y = Global.gravity * 0.7
	p.sprite.flip_h = p.velocity.x <= 0
	p.anim.play("dive")
	if p.is_on_floor() and not p.ceiling_crouch:
		p.sm.change_state("run")
	
	weighty_movement(delta)

func on_exit()-> void:
	p.allow_sprite_flip = true
	%dive.stop()

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.last_x_input * p.run_speed, p.velocity_weight)
