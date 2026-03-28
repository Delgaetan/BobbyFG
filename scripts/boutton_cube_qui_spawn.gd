extends Node2D
@onready var porte_a_piece: Node2D = $"."
@onready var collision_piece: CollisionShape2D = $area_pour_piece/collision_piece
@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var color_rect_2: ColorRect = $ColorRect2




func _on_area_pour_piece_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.porte_a_piece_1 = 1
		color_rect_2.hide()
