extends CharacterBody2D

var direction = 1.0
var speed = 100.0
var can_change_direction = true

@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var sfx_death: AudioStreamPlayer = $sfx_death


func _physics_process(delta: float) -> void:
	velocity.x = speed * direction

	if is_on_wall() and can_change_direction:
		direction *= -1
		can_change_direction = false
		get_tree().create_timer(0.2).timeout.connect(reset_direction_timer)

	if sprite:
		sprite.flip_h = direction == -1
	
	move_and_slide()

func reset_direction_timer():
	can_change_direction = true

	
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		sfx_death.play()
		if body is CharacterBody2D:
			var bounce_strength = 750
			body.velocity.y = -bounce_strength
		
		# Logique de réinitialisation du chrono, correcte et au bon endroit
		if Global.speedrun_time_type == 1:
			Global.speedrun_time = 0.0
		
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		
		get_tree().reload_current_scene()

func _on_meurt_body_entered(body: Node2D) -> void:
	if body.name == "player":
			# Fait rebondir le joueur
			if body is CharacterBody2D:
				var bounce_strength = 500
				body.velocity.y = -bounce_strength
			
			# Crée et lance l'animation de mort
			var tween = create_tween()
			tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
			
			# Attend que l'animation soit terminée
			await tween.finished
			
			# Supprime le méchant
			queue_free()
