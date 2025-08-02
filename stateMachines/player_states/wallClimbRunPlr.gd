extends StatePlr

func on_enter()-> void:
	p.allow_sprite_flip = false
	
	if p.velocity.x > 0:
		p.wall_direction = 1
	elif p.velocity.x < 0:
		p.wall_direction = -1

func process(delta: float)-> void:
	p.sprite.flip_h = p.wall_direction == -1
	
	p.velocity.y = -p.jump_velocity
	
	p.anim.play("wallclimb")
	
	if p.velocity.y > 40:
		p.velocity.y *= 0.8
	
	p.velocity.x = p.wall_direction
	
	if p.is_on_floor() or not p.is_on_wall():
		p.sm.change_state("fallrun")
	
	if p.wall_direction == -p.x_input:
		p.sm.change_state("fallrun")
	
	if Input.is_action_just_pressed("Jump"):
		p.sm.change_state("wallJumpRun")
	

func on_exit()-> void:
	p.allow_sprite_flip = true
