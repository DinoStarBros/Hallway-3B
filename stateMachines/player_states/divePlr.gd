extends StatePlr

func on_enter()-> void:
	p.allow_sprite_flip = false

func process(delta: float)-> void:
	p.velocity.y = Global.gravity * 0.7
	p.sprite.flip_h = p.velocity.x <= 0
	if p.is_on_floor() and not p.ceiling_crouch:
		p.sm.change_state("run")


func on_exit()-> void:
	p.allow_sprite_flip = true
