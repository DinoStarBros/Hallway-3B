extends StatePlr

var jump_pressed: bool = false
var jump_buffer_time: float = 0

func on_enter()-> void:
	p.anim.play("fall")
	jump_pressed = false

func process(delta: float)-> void:
	if p.is_on_floor():
		p.sm.change_state("run")
	
	weighty_movement(delta)
	
	jump_buffer_handling(delta)
	coyote_time_handling()
	
	if p.is_on_wall_only():
		p.sm.change_state("wallclimb")
	
	if Input.is_action_pressed("Down") and abs(p.velocity.x) > 800:
		p.sm.change_state("slide")

func on_exit()-> void:
	pass

func jump_buffer_handling(delta: float)-> void:
	if Input.is_action_just_pressed("Jump"):
		jump_pressed = true
	if jump_pressed:
		jump_buffer_time += delta
	else:
		jump_buffer_time = 0
	if jump_buffer_time >= 0.01 and jump_buffer_time <= 0.2:
		if p.is_on_floor():
			p.sm.change_state("jump")

func coyote_time_handling()-> void:
	if p.coyote_time <= p.coyote_threshold:
		if Input.is_action_just_pressed("Jump"):
			p.sm.change_state("jump")

func controlled_movement(_delta: float) -> void:
	p.velocity.x = p.walk_speed * p.x_input

func weighty_movement(delta: float) -> void:
	p.x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	p.velocity_weight = delta * (p.acceleration if p.x_input else p.friction)
	p.velocity.x = lerp(p.velocity.x, p.last_x_input * p.run_speed, p.velocity_weight)
