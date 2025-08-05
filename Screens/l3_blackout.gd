extends Node

func _ready() -> void:
	Global.power_outage = false

func _on_blackout_trig_area_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalSignals.L3_Blackout.emit()
		Global.power_outage = true
		%music.stop()
		%power_out.play()
		%power_out2.play()
		%CollisionShape2D.queue_free()
