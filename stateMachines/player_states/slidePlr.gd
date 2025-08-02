extends StatePlr

func on_enter()-> void:
	p.anim.play("slide")
	p.allow_sprite_flip = false

func process(delta: float)-> void:
	p.sprite.flip_h = p.velocity.x <= 0
	
	if not Input.is_action_pressed("Down") and not p.ceiling_crouch:
		p.sm.change_state("run")
	
	if not p.is_on_floor():
		p.sm.change_state("dive")

func on_exit()-> void:
	p.allow_sprite_flip = true
