extends Node2D

class_name Damageable

var _health: int

func set_health(target_value: int):
	_health = target_value
	
func get_health() -> int:
	return _health
	
func receive_damage(damage: int):
	pass
