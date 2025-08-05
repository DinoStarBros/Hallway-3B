extends Node

@export var power_outage : bool = false
@export var next_lvl_scn : String

func _ready() -> void:
	Global.entity_container = %entities
	%music.process_mode = Node.PROCESS_MODE_ALWAYS
	GlobalSignals.Jumpscared.connect(_on_jumpscared)
	GlobalSignals.Next_Level.connect(_next_level)
	GlobalSignals.L3_Blackout.connect(l3_blck)
	
	Global.power_outage = power_outage
	
	light_set()

func l3_blck() -> void:
	Global.power_outage = true
	light_set()

func light_set() -> void:
	%darkness.visible = Global.power_outage
	%DirectionalLight2D.visible = Global.power_outage

func _on_jumpscared() -> void:
	%music.stop()

# For da credits:
# hergergy.itch.io/input-prompts
# pixabay.com
# kenney.nl

# Godot 4.4.1
# Krita
# Aseprite
# Labchirp

func _next_level() -> void:
	Global.scene_change(next_lvl_scn)
