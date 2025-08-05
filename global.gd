extends Node

var entity_container : Node2D
var cam : PlrCamera
var camRect : ColorRect
var screen_corners : Rect2
var player : Player
var enemy_arrows : Node
var power_outage : bool = false

var attack : Attack = Attack.new()

var score : int = 0
var killscore : int = 0

var xp : int = 0
var next_lvl_xp : int = 20
var level : int = 1

enum game_states {
	Gameplay, Lost
}
var game_state : game_states = game_states.Gameplay

func _init() -> void:
	volume_handle()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

var master_volume : float = 0.75
var music_volume : float = 0.75
var sfx_volume : float = 0.75
var screen_shake_value : bool = true
var frame_freeze_value : bool = true
var resolution_index : int

func _process(_delta:float)->void:
	volume_handle()

func frame_freeze(timescale: float, duration: float) -> void: ## Slows down the engine's time scale, slowing down the time, for a certain duration. Use for da juice
	if frame_freeze_value:
		Engine.time_scale = timescale
		await get_tree().create_timer(duration, true, false, true).timeout
		Engine.time_scale = 1.0

func volume_handle() -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(sfx_volume)
	)

var gravity : float = 1500

func game_over() -> void:
	get_tree().change_scene_to_file("res://Screens/GameOver/game_over.tscn")

func scene_change(scene : String) -> void:
	SceneManager.change_scene(
		scene, {
			
			"pattern_enter" : "fade",
			"pattern_leave" : "fade",
			
			}
		)
