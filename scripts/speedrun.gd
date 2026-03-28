extends CanvasLayer

func _process(delta):
	update_ui()
	
func update_ui():
	var minutes = int(Global.speedrun_time / 60)
	var seconds = int(fmod(Global.speedrun_time, 60))
	var milliseconds = int(fmod(Global.speedrun_time * 1000, 1000))
	
	$Label.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
