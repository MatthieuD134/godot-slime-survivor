extends Control

signal unpause()


func _on_continue_button_pressed():
	unpause.emit()


func _on_options_button_pressed():
	pass


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/user-interface/main_menu.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
