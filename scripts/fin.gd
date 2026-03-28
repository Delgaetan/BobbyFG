extends Node2D

@onready var win: AudioStreamPlayer = $win


var is_transitioning = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and not is_transitioning:
		win.play()
		
		# Met le chronomètre en pause
		Global.is_timer_paused = true
		
		Global.porte_a_piece_1 = 0
		
		is_transitioning = true
		
		set_deferred("monitoring", false)
		set_deferred("collision_layer", 0)
		set_deferred("collision_mask", 0)

		var player = body

		Engine.time_scale = 0.2
		
		var tween = create_tween()
		tween.tween_property(player, "rotation", player.rotation + 1 * PI, 1.0)
		tween.finished.connect(transition_to_next_level)

func transition_to_next_level() -> void:
	Engine.time_scale = 1.0
	
	# Réinitialise le temps si le mode est "Niv"
	if Global.speedrun_time_type == 1:
		Global.speedrun_time = 0.0

	# ici je masi tout les niv pour que sa change authomatiquement
	if Global.next_niv == 1:
		Global.next_niv = 2
		get_tree().change_scene_to_file("res://niv2.tscn")
	
	elif Global.next_niv == 2:
		Global.next_niv = 3
		get_tree().change_scene_to_file("res://niv3.tscn")
		
	elif Global.next_niv == 3:
		Global.next_niv = 4
		get_tree().change_scene_to_file("res://niv4.tscn")
		
	elif Global.next_niv == 4:
		Global.next_niv = 5
		get_tree().change_scene_to_file("res://niv5.tscn")
	
	elif Global.next_niv == 5:
		Global.next_niv = 6
		get_tree().change_scene_to_file("res://niv6.tscn")
	
	elif Global.next_niv == 6:
		Global.next_niv = 7
		get_tree().change_scene_to_file("res://niv7.tscn")
