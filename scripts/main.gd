extends Node2D

@onready var poles : PackedScene

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS 
	Autoload.game_state_changed.connect(_on_game_state_change)
	Autoload.score_updated.connect(_on_score_update)
	Autoload.current_game_state = Autoload.GameState.START
	Autoload.score = 0
	


func _process(delta: float) -> void:
	$CanvasLayer/Control/Label.text = str(Autoload.score)
	
	if Autoload.current_game_state == Autoload.GameState.START and Input.is_action_just_pressed("interact"):
		Autoload.current_game_state = Autoload.GameState.PLAYING
	
	if Autoload.current_game_state == Autoload.GameState.GAME_OVER and Input.is_action_just_pressed("interact"):
		restart_game()
	
func _on_game_state_change(new_state: Autoload.GameState) -> void:
	match new_state:
		Autoload.GameState.START:
			show_start_screen()
			get_tree().paused = true
		Autoload.GameState.PLAYING:
			# Απόκρυψη όλων των οθονών UI
			$CanvasLayer2/StartScreen.visible = false
			$CanvasLayer2/GameOver.visible = false
			# Συνέχιση του παιχνιδιού
			get_tree().paused = false
			$Timer.start()
		Autoload.GameState.GAME_OVER:
			# Εμφάνιση οθόνης Game Over με το σκορ
			$CanvasLayer2/GameOver/Score.text = "SCORE -> " + str(Autoload.score)
			$CanvasLayer2/GameOver.visible = true
			$CanvasLayer2/StartScreen.visible = false
			get_tree().paused = true
			

func _on_timer_timeout() -> void:
	var rand_index = randi() %Autoload.obstacles.size()
	var poleInstance = Autoload.obstacles[rand_index].instantiate()
	poleInstance.position.x = 1920
	#poleInstance.position.y = randi_range(Autoload.pole_area_min,Autoload.pole_area_max)
	add_child(poleInstance)
	$Timer.start()
	

func _on_score_update():
	if Autoload.score % 5 ==0 and Autoload.score > 0 and $Timer.wait_time >= 1.0:
		$Timer.wait_time -= 0.1


func show_start_screen():
	$CanvasLayer2/StartScreen.visible = true
	$CanvasLayer2/GameOver.visible = false

func restart_game():
	# Καθαρισμός όλων των poles και abilities από την οθόνη
	for child in get_children():
		# Μην διαγράφεις τα CanvasLayer, Timers, Player κλπ.
		if child is Node2D and child.name != "Player" and child.name != "CanvasLayer" and child.name != "CanvasLayer2" and child.name != "ParallaxBackground":
			child.queue_free()
	
	# Επαναφορά θέσης παίκτη
	$Player.position = Vector2(100, 300)
	
	# Επαναφορά μεταβλητών
	Autoload.score = 0
	Autoload.default_speed = 400
	Autoload.deactivate_ability()
	
	# Επιστροφή στην κατάσταση START
	Autoload.current_game_state = Autoload.GameState.START


#func start_game():
	##Autoload.current_game_state=Autoload.GameState.PLAYING
	#$CanvasLayer2/StartScreen.visible = false
	#get_tree().paused = false
	#
	#$Timer.start()
#
#func game_over():
	##Autoload.current_game_state = Autoload.GameState.GAME_OVER
	#get_tree().paused = true
	#$CanvasLayer2/GameOver/Score.text = "SCORE -> " + str(Autoload.score)
	#$CanvasLayer2/GameOver.visible = true
	#$CanvasLayer2/StartScreen.visible = false
#
#func restart_game():
	## Reset player position
	#$Player.position = Vector2(100, 300)
	#Autoload.score = 0
	#Autoload.default_speed = 400
	#Autoload.deactivate_ability()
	#start_game()
	#
	#if Autoload.current_game_state == Autoload.GameState.GAME_OVER:
		#if Input.is_action_just_pressed("interact"):
			#start_game()  # Θα χρειαστεί να υλοποιήσεις την επανεκκίνηση


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_quit_2_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
