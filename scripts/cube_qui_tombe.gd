extends Node2D

@onready var color_rect: ColorRect = $CharacterBody2D/ColorRect
@onready var area_2d: Area2D = $CharacterBody2D/Area2D




var is_animating = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and not is_animating:
		is_animating = true
		
		if area_2d:
			area_2d.set_deferred("monitoring", false)
			area_2d.set_deferred("collision_layer", 0)
			area_2d.set_deferred("collision_mask", 0)
		
		# --- Tremblement rapide sur le parent (Node2D) ---
		var initial_position = self.position
		var shake_tween = create_tween()
		shake_tween.set_loops(3)
		shake_tween.tween_property(self, "position", initial_position + Vector2(15, 0), 0.05)
		shake_tween.tween_property(self, "position", initial_position - Vector2(15, 0), 0.05)
		
		# Attend une seconde
		await get_tree().create_timer(1.0).timeout
		
		# --- Chute rapide et disparition sur le parent (Node2D) ---
		var disappear_tween = create_tween()
		
		# Fait tomber l'objet entier (le Node2D parent)
		disappear_tween.tween_property(self, "position", self.position + Vector2(0, 500), 0.5)
		
		# Fait disparaître la couleur (sur l'enfant ColorRect) et rapetisse le parent (Node2D)
		disappear_tween.parallel().tween_property(color_rect, "modulate:a", 0.0, 0.5)
		disappear_tween.parallel().tween_property(self, "scale", Vector2.ZERO, 0.5)
		
		await disappear_tween.finished
		
		queue_free()
