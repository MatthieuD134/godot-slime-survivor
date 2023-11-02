extends Node2D


@onready var enemy_scene = load("res://scenes/enemies/enemy.tscn")
@onready var player: CharacterBody2D = %Player
@onready var enemies: Node2D = %Enemies
@onready var pauseMenu: Control = %PauseMenu
@onready var gameOverMenu: Control = %GameOverMenu

@export var enemy_spawn_range: float


func _ready():
	pauseMenu.set_visible(false)
	gameOverMenu.set_visible(false)
	Engine.set_time_scale(1)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()

func pause_menu():
	pauseMenu.set_visible(true)
	Engine.set_time_scale(0)

# -------------------------
# HANDLING EXTERNAL SIGNALS
# -------------------------
func _on_enemy_spawn_timer_timeout():
	var base_enemy_scene = enemy_scene.instantiate() as CharacterBody2D
	var random_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	base_enemy_scene.position = player.get_position() + random_direction * enemy_spawn_range
	enemies.add_child(base_enemy_scene)


func _on_pause_menu_unpause():
	pauseMenu.set_visible(false)
	Engine.set_time_scale(1)


func _on_player_player_died():
	gameOverMenu.set_visible(true)
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0, 0.5)
