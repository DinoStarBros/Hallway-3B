extends CanvasLayer

var speed_lines : Array[Node2D]

@onready var speed_lines_parent: Node2D = %speed_lines_parent
@onready var p : Player = get_parent() ## Reference to the Parent Node, Dumby

@export var max_frame : int = 6

func _ready() -> void:
	for n in speed_lines_parent.get_children():
		speed_lines.append(n)
		# Adds all the speed lines into an array

func _physics_process(delta: float) -> void:
	#var idx : int = _dir_matcher(%PlaneSprite.rotation_degrees)
	var idx : int = _dir_matcher(rad_to_deg(p.velocity.angle()))
	
	for n in speed_lines:
		n.rotation_degrees = (idx * (180 / max_frame) ) + 90
	
	# Checks if the player (Dumby) speed (magnitude/length of the Velocity Vector) ff it's greater than 850
	# Doing so activates SICK ANIME SPEED LINES (inspired by YOMI Hustle) for da JUICE!
	speed_lines_parent.visible = p.velocity.length() > 1000# and p.accelerating and p.accelerate_time > 1.2

func _dir_matcher(_rot : float) -> int:
	var index :float
	
	if _rot > 0: # Positive angle
		index = max_frame - abs(remap(_rot, 180, 0, max_frame/2, -max_frame/2))
	else: # Negative Angle
		index = abs(remap(_rot, -180, 0, max_frame/2, -max_frame/2))
	
	if abs(_rot) > 90: # Checks if the sprite is facing the left
		speed_lines_parent.scale.x = -1
	else:
		speed_lines_parent.scale.x = 1
	
	return round(index)
