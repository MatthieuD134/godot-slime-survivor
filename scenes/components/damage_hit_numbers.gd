extends Node2D
class_name DamageHitNumbers

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var label_component: Label = %Label
@onready var label_container: Node2D = %LabelContainer

func _ready():
	pass

func set_label_and_animate(label: String, start_pos:Vector2, height: float, spread: float) -> void:
	label_component.set_text(label)
	animation_player.play("rise_and_fade")
	
	var tween = create_tween()
	var end_pos = Vector2(randf_range(-spread, spread), -height) + start_pos
	var tween_duration = animation_player.get_animation("rise_and_fade").length
	
	tween.tween_property(label_container, "position", end_pos, tween_duration).from(start_pos)
