extends StatePlr

func on_enter()-> void:
	pass

func process(delta: float)-> void:
	if p.x_input == 0:
		p.anim.play("idle")
	else:
		p.anim.play("walk")
	
	controlled_movement(delta)
	
	if Input.is_action_just_pressed("Jump") and p.is_on_floor():
		p.sm.change_state("jump")
	
	if p.velocity.y >= 1:
		p.sm.change_state("fall")
	
	if Input.is_action_pressed("Run"):
		p.sm.change_state("run")
	
	if Input.is_action_pressed("Down"):
		p.sm.change_state("crouch")

func on_exit()-> void:
	pass

func controlled_movement(_delta: float) -> void:
	p.velocity.x = p.walk_speed * p.x_input

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.walk_speed, p.velocity_weight)
