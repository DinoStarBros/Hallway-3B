extends StatePlr

func on_enter()-> void:
	p.allow_sprite_flip = false
	
	if p.velocity.x > 0:
		p.wall_direction = 1
	elif p.velocity.x < 0:
		p.wall_direction = -1
	

func process(delta: float)-> void:
	p.sprite.flip_h = p.wall_direction == 1
	
	p.anim.play("wallclimb")
	
	if p.velocity.y > 40:
		p.velocity.y *= 0.8
	
	p.velocity.x = p.wall_direction
	
	if p.is_on_floor() or not p.is_on_wall():
		if abs(p.velocity.x) > 600:
			p.sm.change_state("fallrun")
		else:
			p.sm.change_state("fall")
		p.velocity.y = 0
	
	if p.wall_direction == -p.x_input:
		p.coyote_time = 0
		p.sm.change_state("fall")
	
	if Input.is_action_just_pressed("Jump"):
		p.sm.change_state("wallJump")

func on_exit()-> void:
	p.allow_sprite_flip = true
