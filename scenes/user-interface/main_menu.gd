extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/user-interface/options_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
