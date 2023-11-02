extends Area2D

var BASE_DAMAGE: float = 5
var SPEED: float = 160
var LIFESPAN: float = 2000 # In msec

var _is_exploding: bool = false
var _direction: Vector2 = Vector2(0,0)
var _start_time: float

@onready var attack_sprite: Sprite2D = %Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var damage_zone: Area2D = %DamageZone

func _ready():
	_start_time = Time.get_ticks_msec()
	attack_sprite.set_visible(true)

func get_direction():
	return _direction.normalized()
	
func set_direction(new_direction: Vector2):
	_direction = new_direction.normalized()

func _physics_process(delta):
	if !_is_exploding:
		position = position + get_direction() * SPEED * delta

	if (Time.get_ticks_msec() - _start_time) >= LIFESPAN:
		explode()


func explode():
	_is_exploding = true
	animation_player.play("explode")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	
	var second_tween = create_tween()
	second_tween.tween_property(damage_zone, "scale", Vector2(10,10), 0.25)


func _on_body_entered(_body):
	explode()

func _on_area_entered(area):
	explode()


func _on_damage_zone_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(randi_range(int(0.8*BASE_DAMAGE), int(1.2*BASE_DAMAGE)))

func _on_damage_zone_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(randi_range(int(0.8*BASE_DAMAGE), int(1.2*BASE_DAMAGE)))
