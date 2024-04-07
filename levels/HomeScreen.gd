extends Control


func _on_play_continue_pressed():
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")
	pass # Replace with function body.


func _on_game_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.

