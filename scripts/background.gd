extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("========== ΔΙΑΓΝΩΣΗ BACKGROUND ==========")
	#print("Το τρέχον node λέγεται: ", name)
	#print("Τα παιδιά μου είναι:")
	#for child in get_children():
		#print("  - ", child.name, " (", child.get_class(), ")")
	#
	#print("Προσπάθεια πρόσβασης:")
	#print("  $BG1: ", $BG1)
	#print("  $BG2: ", $BG2)
	#print("=========================================")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if $ParallaxBackground/BG1.position.x <= -967.0:
		#$ParallaxBackground/BG1.position.x = $ParallaxBackground/BG2.position.x + sw 
		#
	#if $ParallaxBackground/BG2.position.x <= -967.0:
		#$ParallaxBackground/BG2.position.x = $ParallaxBackground/BG1.position.x + sw 
	pass
