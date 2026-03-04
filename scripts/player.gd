extends CharacterBody2D


const JUMP= -400.0

func _ready() -> void:
	z_index = 15


func _physics_process(delta: float) -> void:
	if Autoload.current_game_state != Autoload.GameState.PLAYING:
		return
	var current_gravity = get_gravity() * Autoload.gravity_mult
	var current_jump = JUMP * Autoload.jump_mult
	# Add the gravity.
	velocity += current_gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("interact"):
		velocity.y = current_jump
		$AnimatedSprite2D3.play("fly")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()
	
