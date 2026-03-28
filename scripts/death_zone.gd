extends Node2D

@onready var sfx_death: AudioStreamPlayer = $sfx_death

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		sfx_death.play()
		
		# Mets le chronomètre en pause dès que le joueur meurt
		Global.is_timer_paused = true
		
		Global.porte_a_piece_1 = 0
		
		if body is CharacterBody2D:
			var bounce_strength = 750
			body.velocity.y = -bounce_strength
		
		# Si le mode est "Niv", réinitialise le chrono
		if Global.speedrun_time_type == 1:
			Global.speedrun_time = 0.0
		
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		
		get_tree().reload_current_scene()
