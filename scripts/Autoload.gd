extends Node2D


var default_speed:=400.0
var screen_width := 3000

var speed_mult := 1.0
var gravity_mult := 1.0
var jump_mult := 1.0
var timer_mult := 1.0	

var ability_active := false
var ability_timer := 0.0

var pole_area_min:=-150
var pole_area_max:=150

enum GameState {START, PLAYING, GAME_OVER}


var obstacles = [preload("res://Scenes/poles00.tscn"),
 preload("res://Scenes/poles_01.tscn"),
 preload("res://Scenes/poles_02.tscn"),
 preload("res://Scenes/poles_03.tscn"),
preload("res://Scenes/poles_04.tscn")]

var ability_choices = [preload("res://Scenes/control.tscn"),
 preload("res://Scenes/speed.tscn"),
preload("res://Scenes/penalty.tscn")]

signal score_updated(new_score)
var score := 0:
	set(new_value):
		score = new_value
		score_updated.emit(score)

#signal god_mode_changed(is_active)
#var god_mode := false:
	#set(new_value):
		##print("GOD MODE CHANGING from ", god_mode, " to ", new_value)
		#god_mode = new_value
		#god_mode_changed.emit(god_mode)
		
signal game_state_changed(new_state)
var current_game_state : GameState = GameState.START:
	set(new_value):
		current_game_state=new_value
		game_state_changed.emit(current_game_state)
	

func _process(delta: float) -> void:
	if ability_active == true:
		ability_timer -= timer_mult * delta
		if ability_timer <= 0.0:
			deactivate_ability()
			

func activate_ability(ability_type : String, duration : float)-> void:
	match ability_type:
		"speed":
			speed_mult = 1.5
			gravity_mult = 1.2
			jump_mult = 1.2
			timer_mult = 1 / speed_mult
			ability_active = true
			ability_timer = duration
			print("Speed active")
		"control":
			gravity_mult = 0.6
			speed_mult = 1
			jump_mult = 0.6
			ability_active = true
			ability_timer = duration
			print("Control active")
		#"god_mode":
			#god_mode = true
			#ability_active = true
			#ability_timer = duration
			#print("God_mode active")
		"penalty":
			speed_mult = 2
			ability_active = true
			ability_timer = duration
			print("penalty active")
	

func deactivate_ability() -> void:
	speed_mult = 1
	timer_mult = 1
	ability_active = false
	gravity_mult = 1
	jump_mult = 1
	#god_mode = false
	ability_active = false
	print("Ability not active")
	
