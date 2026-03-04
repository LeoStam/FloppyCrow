extends Area2D

@export var ability_type : String
@export var duration := 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func collect_ability() -> void:
	Autoload.activate_ability(ability_type, duration)
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.1).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collect_ability()
