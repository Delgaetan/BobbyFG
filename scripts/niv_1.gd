extends Node2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	Global.is_timer_paused = false
	if Global.musique == 1:
		audio_stream_player.play()
