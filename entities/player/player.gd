extends CharacterBody2D
class_name Player

# References to Nodes
@onready var anim: AnimationPlayer = %animation
@onready var sm: StateMachinePlayer = %stateMachine
@onready var sprite: Sprite2D = %sprite
@onready var collision_box: CollisionShape2D = %collisionBox

# Variables
var x_input : float
var velocity_weight : float
var coyote_time : float = 0
var last_x_input : float
var dir_to_mouse : Vector2
var allow_sprite_flip : bool = true ## Turn false if player is in state where they're forced to face one direction (e.g. wallclimb)
var wall_direction : int = 0
var ceiling_crouch : bool = false
var slowed : bool = false

# Constants
const walk_speed : float = 600
const terminal_velocity_fall : int = 1500
const jump_velocity : float = 700
const run_speed : float = 1200
const acceleration : float = 10
const friction : float = 5
const crouch_speed : float = 300
const climb_speed : float = 500
const coyote_threshold : float = 0.15

# Arrays
var crouch_ceiling_raycasts_collisions : Array 
var ceiling_shift_raycast_collisions : Array

func _ready() -> void:
	Global.player = self
	Global.cam = %camera
	
	light_set()
	GlobalSignals.L3_Blackout.connect(l3_blck)

func light_set() -> void:
	await get_tree().create_timer(0.1).timeout
	%Lights.visible = Global.power_outage

func l3_blck() -> void:
	light_set()

func _physics_process(delta: float) -> void:
	crouch_ceiling_raycasts_collisions = [
	%crouch_celingl.is_colliding(),
	%crouch_celingc.is_colliding(),
	%crouch_celingr.is_colliding()
	]
	ceiling_shift_raycast_collisions = [
	%ceiling_shift_l.is_colliding(),
	%ceiling_shift_c.is_colliding(),
	%ceiling_shift_r.is_colliding()
	]
	
	if slowed:
		velocity.x /= 1.2
	%blind.visible = slowed
	
	ceiling_crouch = crouch_ceiling_raycasts_collisions.count(true) > 0
	
	#%sm_text.text = str(coyote_time)
	
	move_and_slide()
	if not is_on_floor():
		#if velocity.y > 0:
		coyote_time += delta
		if velocity.y >= 50:
			# Falls faster when going down
			velocity.y += Global.gravity * delta * 2
		else:
			velocity.y += Global.gravity * delta 
		
		if velocity.y >= terminal_velocity_fall:
			velocity.y = terminal_velocity_fall
	else:
		coyote_time = 0
	
	x_input = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if x_input != 0:
		last_x_input = x_input
	
	if allow_sprite_flip:
		sprite.flip_h = last_x_input == -1

func initialize_properties() -> void:
	sprite.scale = Vector2(2,2)
	sprite.rotation_degrees = 0
	sprite.position = Vector2(0,-32)
	sprite.modulate = Color.WHITE
	
	collision_box.shape.size = Vector2(40, 70)
	collision_box.position = Vector2(0,-35)

var aim_position : Vector2
var half_viewport : Vector2
func _unhandled_input(event: InputEvent) -> void: ## For camera aiming, dynamic camera follow mouse
	half_viewport = get_viewport_rect().size / 2.0
	
	if event is InputEventMouseMotion:
		aim_position = (event.position - half_viewport)
		
		#%Crosshair.global_position = get_global_mouse_position()

func start_antiblind_timer() -> void:
	%antiBlindTimer.start(4)

func _on_anti_blind_timer_timeout() -> void:
	slowed = false
