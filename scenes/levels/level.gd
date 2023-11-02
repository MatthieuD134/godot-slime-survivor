extends Node2D


@onready var enemy_scene = load("res://scenes/enemies/enemy.tscn")
@onready var player: CharacterBody2D = %Player
@onready var enemies: Node2D = %Enemies

@export var enemy_spawn_range: float

# -------------------------
# HANDLING EXTERNAL SIGNALS
# -------------------------
func _on_enemy_spawn_timer_timeout():
	var base_enemy_scene = enemy_scene.instantiate() as CharacterBody2D
	var random_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	base_enemy_scene.position = player.get_position() + random_direction * enemy_spawn_range
	enemies.add_child(base_enemy_scene)
