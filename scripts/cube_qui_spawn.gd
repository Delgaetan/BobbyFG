extends Node2D
@onready var pieces: Node2D = $"."
@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/CollisionShape2D





func _physics_process(delta: float) -> void:
	if Global.porte_a_piece_1 == 1:
		pieces.show()
		collision_shape_2d.disabled = false

		
	elif Global.porte_a_piece_1 == 0:
		if Global.piece_1 == 0:
			pieces.hide()
			collision_shape_2d.disabled = true
