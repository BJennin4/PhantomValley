extends Timer

func _on_dialogue_start_timer():
	start(wait_time)


func _on_dialogue_stop_timer():
	stop()
