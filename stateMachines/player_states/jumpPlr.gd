extends StatePlr

func on_enter()-> void:
	p.anim.play("jump")
	p.velocity.y = -p.jump_velocity

func process(delta: float)-> void:
	controlled_movement(delta)
	
	if not Input.is_action_pressed("Jump"):
		p.velocity.y *= 0.3
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")
	
	if p.is_on_floor():
		p.sm.change_state("walk")
	
	if p.is_on_wall_only():
		p.sm.change_state("wallclimb")
	
	ceiling_shift_handle()

func on_exit()-> void:
	pass

func controlled_movement(_delta: float) -> void:
	p.velocity.x = p.walk_speed * p.x_input

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.x_input * p.max_speed, p.velocity_weight)

func ceiling_shift_handle() -> void:
	if p.ceiling_shift_raycast_collisions[1] == false: # Has to make sure ur not in the center of the ceiling
		# If you're, it wont shift
		if p.ceiling_shift_raycast_collisions[0] == true: # Left rc ceiling shift
			p.position.x += 14
		elif p.ceiling_shift_raycast_collisions[2] == true: # Right rc ceiling shift
			p.position.x -= 14
