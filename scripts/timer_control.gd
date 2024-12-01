extends Timer

var change = 0.025

func _process(_delta):
	if Input.is_action_just_pressed("play_pause"):
		paused = !paused

	if Input.is_action_just_pressed("slow_down"):
		wait_time += change

	if Input.is_action_just_pressed("speed_up"):
		wait_time = max(wait_time - change, change)
