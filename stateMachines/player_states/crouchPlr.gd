extends StatePlr

func on_enter()-> void:
	pass

func process(delta: float)-> void:
	if p.x_input == 0:
		p.anim.play("crouch")
	else:
		p.anim.play("crouchwalk")
	
	controlled_movement(delta)
	
	if not Input.is_action_pressed("Down") and not p.ceiling_crouch:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass

func controlled_movement(_delta: float) -> void:
	p.velocity.x = p.crouch_speed * p.x_input
