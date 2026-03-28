extends Control

@onready var label: Label = $Panel/speedrun/Label
@onready var label_musique: Label = $Panel/musique/Label

func _ready():
	if Global.speedrun_time_type == 1:
		label.text = "Niv"
	elif Global.speedrun_time_type == 2:
		label.text = "Any%"
	
	if Global.musique == 1:
		label_musique.text = "on"
	elif Global.musique == 2:
		label_musique.text = "off"

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_speedrun_pressed() -> void:
	if Global.speedrun_time_type == 1:
		label.text = "Any%"
		Global.speedrun_time_type = 2
	elif Global.speedrun_time_type == 2:
		label.text = "Niv"
		Global.speedrun_time_type = 1

func _on_musique_pressed() -> void:
	if Global.musique == 1:
		label_musique.text = "off"
		Global.musique = 2
	elif Global.musique == 2:
		label_musique.text = "on"
		Global.musique = 1
