extends CharacterBody2D

signal damage_taken(damage: int)
signal healing_received(amount: int)

@onready var base_attack_scene = load("res://scenes/player/spells/base_attack.tscn")

@onready var BASE_MOVEMENT_SPEED: int = 64
@onready var current_direction: Vector2 = Vector2(1,0)
@onready var sprite: Sprite2D = %PlayerSprite
@onready var health_component: HealthComponent = %HealthComponent
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var base_spell: Node2D = %Spells/BaseSpell

@export var player_spells_node: Node2D

func _ready():
	sprite.set_visible(true)
	assert(player_spells_node, "You must assign a spells node to the Player object")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction != Vector2(0,0):
		current_direction = direction
		set_velocity(direction * BASE_MOVEMENT_SPEED * delta)
		move_and_collide(velocity)

func take_damage(damage: int):
	damage_taken.emit(damage)

func receive_healing(amount:int):
	healing_received.emit(amount)

func kill():
	animation_player.play("player_death")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)

# -------------------------
# HANDLING EXTERNAL SIGNALS
# -------------------------
func _on_base_spell_timer_timeout():
	var base_attack = base_attack_scene.instantiate() as Area2D
	base_attack.position = self.global_position
	base_attack.set_direction(current_direction)
	player_spells_node.add_child(base_attack)

func _on_health_component_died():
	kill()

func _on_health_component_damage_taken(damage):
	animation_player.play("player_damaged")
