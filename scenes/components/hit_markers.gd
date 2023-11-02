extends Node

@export var height: float
@export var spread: float

@onready var spawnPosition: Marker2D = %SpawnPosition
@onready var damage_hit_numbers_scene = load("res://scenes/components/damage_hit_numbers.tscn")


func create_hit_marker(damage: int) -> void:
	var new_hit_number_scene = damage_hit_numbers_scene.instantiate() as DamageHitNumbers
	self.add_child(new_hit_number_scene)
	new_hit_number_scene.set_label_and_animate(str(damage), spawnPosition.get_position(), height, spread)


func _on_health_component_damage_taken(damage: int) -> void:
	create_hit_marker(damage)
