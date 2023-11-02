extends Area2D

@export var body_reference: Node2D

func _ready():
	assert(body_reference, "HitBox Component must have a body reference attached")

func take_damage(damage: int):
	if body_reference.has_method("take_damage"):
		body_reference.take_damage(damage)
