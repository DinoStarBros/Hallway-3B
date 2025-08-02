extends Node

var game : Game 
var enemy_container : Node2D
var cam : PlrCamera
var camRect : ColorRect
var screen_corners : Rect2
var player : Player
var enemy_arrows : Node

var attack : Attack = Attack.new()

var score : int = 0
var killscore : int = 0

var xp : int = 0
var next_lvl_xp : int = 20
var level : int = 1

func _init() -> void:
	volume_handle()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

var master_volume : float
var music_volume : float
var sfx_volume : float
var screen_shake_value : bool 
var frame_freeze_value : bool
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
