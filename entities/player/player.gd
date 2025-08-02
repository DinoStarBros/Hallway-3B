extends CharacterBody2D
class_name Player

# References to Nodes
@onready var anim: AnimationPlayer = %animation
@onready var sm: StateMachinePlayer = %stateMachine
@onready var sprite: Sprite2D = %MelonSprites
@onready var collision_box: CollisionShape2D = %collisionBox

var x_input : float
var velocity_weight : float
var coyote_time : float = 0
var last_x_input : float
var dir_to_mouse : Vector2
var allow_sprite_flip : bool = true ## Turn false if player is in state where they're forced to face one direction (e.g. wallclimb)
var wall_direction : int = 0
var ceiling_crouch : bool = false

# Constants
const walk_speed : float = 500
const terminal_velocity_fall : int = 1500
const jump_velocity : float = 700
const run_speed : float = 1200
const acceleration : float = 2
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
	
	ceiling_crouch = crouch_ceiling_raycasts_collisions.count(true) > 0
	
	%sm_text.text = str(coyote_time)
	
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
	sprite.scale = Vector2(.2,.2)
	sprite.rotation_degrees = 0
	sprite.position = Vector2(0,-38)
	sprite.modulate = Color.WHITE
	
	collision_box.shape.size = Vector2(56, 70)
	collision_box.position = Vector2(0,-35)
