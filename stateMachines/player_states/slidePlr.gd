extends StatePlr

func on_enter()-> void:
	p.anim.play("slide")
	p.allow_sprite_flip = false
	%slide.play()

func process(_delta: float)-> void:
	p.sprite.flip_h = p.velocity.x <= 0
	
	if not Input.is_action_pressed("Down") and not p.ceiling_crouch:
		p.sm.change_state("run")
	
	if not p.is_on_floor():
		p.sm.change_state("dive")
	
	if p.is_on_wall():
		p.sm.change_state("crouch")

func on_exit()-> void:
	%slide.stop()
	p.allow_sprite_flip = true
