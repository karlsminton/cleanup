extends Button


func _on_pressed_start_button() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Overworld.tscn")

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
