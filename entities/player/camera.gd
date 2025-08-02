extends Camera2D
class_name PlrCamera

var shake_intensity: float = 0.0
var active_shake_time:float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise : FastNoiseLite = FastNoiseLite.new()
@export var lock_camera : bool = false
var deltaTime : float
func _ready():
	pass

func _physics_process(delta:float) -> void:
	deltaTime = delta
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		if Global.screen_shake_value:
			offset = Vector2(
				noise.get_noise_2d(shake_time, 0) * shake_intensity,
				noise.get_noise_2d(0, shake_time) * shake_intensity,
			)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)

func screen_shake(intensity: int, time: float): ## Shakes the camera with an intensity, for some duration of time, Use for da juice
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0

const cam_lim_allowance : int = 100

var lim_top : float
var lim_left : float
var lim_bottom : float
var lim_right : float

@onready var plr : Player = get_parent()
func _on_room_detect_area_area_entered(area: Area2D) -> void:
	#if area is CheckPointArea:
	#	plr.checkpoint = area.checkpoint
	
	if area is RoomArea:
		var shape : CollisionShape2D = area.room
		var size : Vector2 = shape.shape.size
		
		var cam = self
		
		lim_top = shape.global_position.y - size.y / 2 - cam_lim_allowance
		lim_left = shape.global_position.x - size.x / 2 - cam_lim_allowance
		
		lim_bottom = shape.global_position.y + size.y / 2 + cam_lim_allowance
		lim_right = shape.global_position.x + size.x / 2 + cam_lim_allowance
		
		if lock_camera:
			cam.limit_top = lim_top
			cam.limit_left = lim_left
			
			cam.limit_bottom = lim_bottom
			cam.limit_right = lim_right
