extends StatePlr

func on_enter()-> void:
	pass

func process(delta: float)-> void:
	weighty_movement(delta)
	p.anim.play("run")
	
	if not Input.is_action_pressed("Run"):
		p.sm.change_state("walk")
	
	if Input.is_action_just_pressed("Jump") and p.is_on_floor():
		p.sm.change_state("jumprun")
	
	if Input.is_action_pressed("Down") and abs(p.velocity.x) > 200:
		p.sm.change_state("slide")

func on_exit()-> void:
	pass

func controlled_movement(_delta: float) -> void:
	p.velocity.x = p.run_speed * p.x_input

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.last_x_input * p.run_speed, p.velocity_weight)
