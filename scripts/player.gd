extends CharacterBody2D

@onready var sprite_2d = $Visual/Bobby
@onready var visual_node = $Visual
@onready var sfx_jump: AudioStreamPlayer = $sfx_jump

const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const JUMP_CUT_MULTIPLIER = 0.5 


const COYOTE_TIME = 0.17
var coyote_timer = 0.0

var jump_count = 0
var was_airbourn := false

func _physics_process(delta: float) -> void:

	if is_on_floor():
		if was_airbourn:
			was_airbourn = false
			sprite_2d.scale = Vector2(1.3, 0.7)
		# Réinitialiser le timer quand on touche le sol
		coyote_timer = COYOTE_TIME
	else:
		velocity += get_gravity() * delta
		was_airbourn = true
		# Décrémenter le timer quand on n'est PAS au sol
		coyote_timer -= delta

	if is_on_floor():
		jump_count = 0

	# --- Saut variable (doit être avant le mouvement) ---
	# Si le bouton de saut est relâché ET que le personnage monte encore (velocity.y < 0)
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= JUMP_CUT_MULTIPLIER
		
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		if Global.speedrun_time_type == 1:
			Global.speedrun_time = 0.0
		
	
	# --- Gestion du saut initial et du double saut ---
	if Input.is_action_just_pressed("jump"):
		# Vérifier si on est au sol OU s'il reste du Coyote Time
		if is_on_floor() or coyote_timer > 0.0: 
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0 # Consommer le Coyote Time
			sprite_2d.scale = Vector2(0.7, 1.3)
			sfx_jump.play()
		elif jump_count < 1:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			_do_double_jump_spin()
			sfx_jump.play()

			

	# --- Mouvement horizontal ---
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- Application du mouvement et du squash/stretch ---
	move_and_slide()

	sprite_2d.scale.x = move_toward(sprite_2d.scale.x, 1, 3 * delta)
	sprite_2d.scale.y = move_toward(sprite_2d.scale.y, 1, 3 * delta)


func _do_double_jump_spin():
	var direction_input = Input.get_axis("left", "right")
	var spin_degrees

	if direction_input < 0: # Si la direction est négative (vers la gauche)
		spin_degrees = -360
	else: # Si la direction est positive ou nulle
		spin_degrees = 360

	visual_node.rotation_degrees = 0
	var tween = create_tween()
	tween.tween_property(visual_node, "rotation_degrees", spin_degrees, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
