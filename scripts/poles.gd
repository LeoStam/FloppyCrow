extends Node2D

#@onready var ability : PackedScene = preload("res://Scenes/god_mode.tscn")
#@onready var ability : PackedScene = preload("res://Scenes/control.tscn")
@onready var ability



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("POLES READY - God mode status: ", Autoload.god_mode)
	#Autoload.god_mode_changed.connect(_on_god_mode_changed)
	if randi() % 3 == 0:
		spawn_ability() 
		
	#_on_god_mode_changed(Autoload.god_mode)   
		
							  
func spawn_ability() -> void:
	#var ab = ability.instantiate()
	var random_index = randi() %Autoload.ability_choices.size()
	ability = Autoload.ability_choices[random_index].instantiate()
	ability.position = Vector2(1950, 260)
	add_child(ability)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Autoload.current_game_state != Autoload.GameState.PLAYING:
		return
		
	var current_speed = Autoload.default_speed * Autoload.speed_mult
	position.x -= current_speed * delta
	#$Timer.wait_time *= Autoload.timer_mult
	
	# Έλεγχος αν βγήκε από την οθόνη
	if position.x < -2170:  # Όταν περάσει αριστερά
		queue_free()  # Κατάργησε το pole
	
	#if Autoload.speed_mult != 1:
		#print(current_speed)

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	Autoload.score += 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Autoload.current_game_state = Autoload.GameState.GAME_OVER
