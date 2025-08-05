extends CharacterBody2D

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		%anim.play("flash")
		%htiboxcol.disabled = true
		%Icon.visible = false
		body.slowed = true
		body.start_antiblind_timer()
		
		Global.frame_freeze(0.5, 0.2)
		Global.cam.screen_shake(10, 0.3)

var deltaTime : float = 0
func _process(delta: float) -> void:
	deltaTime += delta
	global_position.y += sin(deltaTime) * delta * 20
