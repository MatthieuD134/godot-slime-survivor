extends CharacterBody2D

signal damage_taken(damage: int)
signal healing_received(amount: int)

@export var BASE_MOVEMENT_SPEED: int = 32
@export var BASE_DAMAGE: int = 5
var can_move: bool = true
var can_deal_damage: bool = true

@onready var shadow: Sprite2D = %Shadow
@onready var sprite: Sprite2D = %Sprite2D
@onready var health_component: HealthComponent = %HealthComponent
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var enemy_hitbox_area: Area2D = %HitBox

func _ready():
	shadow.set_visible(true)
	sprite.set_visible(true)

func _physics_process(delta):
	# Check for player in the tree and move to player
	var player = get_tree().get_root().find_child("Player",true,false)
	if player and can_move:
		var direction = Vector2(player.position.x - position.x, player.position.y - position.y).normalized()
		set_velocity(direction * BASE_MOVEMENT_SPEED * delta)
		move_and_collide(velocity)
	
	# Check for players hitbox in enemie hitbox area to deal damage
	if can_deal_damage:
		for area in enemy_hitbox_area.get_overlapping_areas():
			if area.has_method("take_damage"):
				area.take_damage(BASE_DAMAGE)

func take_damage(damage: int):
	damage_taken.emit(damage)

func receive_healing(amount:int):
	healing_received.emit(amount)
	
func kill():
	can_move = false
	can_deal_damage = false
	animation_player.play("enemy_death")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)


func _on_health_component_died():
	kill()


func _on_health_component_damage_taken(damage):
	animation_player.play("enemy_damage")
