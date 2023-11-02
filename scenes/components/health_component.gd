extends Node
class_name HealthComponent

signal max_health_value_changed(new_max_health: int)
signal health_value_changed(new_health: int)
signal vulnerability_state_changed(state: bool)
signal damage_taken(damage: int)
signal healing_received(amount:int)
signal died()

@export var _max_health: int
@export var _health: int
@export var _is_invulnerable: bool
@export var health_bar: TextureProgressBar

func _ready():
	if health_bar:
		health_bar.set_max(_max_health)
		health_bar.set_value(_health)

# Getter function to get max_health
func get_max_health():
	return _max_health

# Getter function to get current health
func get_health():
	return _health
	
# Getter function to get invulnerability state
func get_is_invulnerable():
	return _is_invulnerable

# Setter function to set max health
func set_max_health(new_max_health: int):
	_max_health = new_max_health
	if health_bar:
		health_bar.set_max(new_max_health)
	max_health_value_changed.emit(new_max_health)

# Setter function to set current health
func set_health(new_health: int):
	_health = new_health
	if health_bar:
		health_bar.set_value(new_health)
	health_value_changed.emit(new_health)

# Setter function to set invulnerability state
func set_is_invulnerable(state: bool):
	_is_invulnerable = state
	vulnerability_state_changed.emit(state)

# Function to be called to handle taking damage
func take_damage(damage: int):
	if get_is_invulnerable(): return
	var health = get_health()
	damage_taken.emit(damage)
	if health > damage:
		set_health(health - damage)
	else:
		set_health(0)
		died.emit()

# Function to be called to handle healing
func heal(amount: int):
	var max_health = get_max_health()
	var health = get_health()
	if max_health > health + amount:
		set_health(health + amount)
	else:
		set_health(max_health)
	healing_received.emit(amount)

# -------------------------
# EXTERNAL SIGNALS HANDLING
# -------------------------
func _on_player_damage_taken(damage):
	take_damage(damage)

func _on_enemy_damage_taken(damage):
	take_damage(damage)

func _on_player_healing_received(amount):
	heal(amount)

func _on_enemy_healing_received(amount):
	heal(amount)
