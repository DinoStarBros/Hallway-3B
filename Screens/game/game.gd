extends Node

func _ready() -> void:
	Global.entity_container = %entities
	%music.process_mode = Node.PROCESS_MODE_ALWAYS
	GlobalSignals.Jumpscared.connect(_on_jumpscared)

func _on_jumpscared() -> void:
	%music.stop()
