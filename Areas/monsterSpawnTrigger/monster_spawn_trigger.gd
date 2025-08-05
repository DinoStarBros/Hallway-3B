extends Area2D

@export var monster_scene : PackedScene
var spawn_location : Node2D

func _ready() -> void:
	for n in get_children():
		if n.name == "spawn_pos":
			spawn_location = n

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		spawn_monster()

func spawn_monster() -> void:
	var monster : CharacterBody2D = monster_scene.instantiate()
	Global.entity_container.add_child(monster)
	monster.global_position = spawn_location.global_position
	queue_free()
