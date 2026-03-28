extends Control

@onready var marker_2d: Marker2D = $"../Marker2D"
@onready var player: CharacterBody2D = $"../TileMap/player"

@export var opacity = Color(1,1,1,0)

var next_niveau = Global.next_niv








func _on_play_button_pressed() -> void:
	if next_niveau == 1:
		get_tree().change_scene_to_file("res://niv selector.tscn")
	elif next_niveau == 2:
		pass
	
	
	
	
	
	
	
	
	
	
	
	

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://options.tscn")

func _on_leave_button_pressed() -> void:
	get_tree().quit(0)

func _physics_process(delta: float) -> void:
	var dist_to = player.global_position.distance_to(marker_2d.global_position)
	if dist_to < 418:
		modulate = lerp(modulate,opacity,0.1)
	else:
		modulate = lerp(modulate,Color(1,1,1,1),0.1)
