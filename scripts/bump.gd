extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/Area2D/CollisionShape2D
@onready var respawn_timer: Timer = $Timer


func _ready() -> void:
	add_child(respawn_timer)
	respawn_timer.timeout.connect(_on_respawn_timer_timeout)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and not collision_shape_2d.disabled:
		collision_shape_2d.disabled = true
		

		respawn_timer.wait_time = 5.0
		respawn_timer.one_shot = true 
		respawn_timer.start()
		if body is CharacterBody2D:
			var bounce_strength = 800
			body.velocity.y = -bounce_strength


func _on_respawn_timer_timeout() -> void:
	collision_shape_2d.disabled = false
