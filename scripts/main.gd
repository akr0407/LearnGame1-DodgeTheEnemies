extends Node2D

@onready var player = $Player
@onready var health_label = $UI/HealthLabel
@onready var game_over_panel = $UI/GameOverPanel

var enemy_scene = preload("res://scenes/enemy.tscn")

const MIN_SPACE_DISTANCE = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_label.text = "Health: " + str(player.health) + " / 100"


func _on_player_died() -> void:
	print("Game Over")
	game_over_panel.visible = true


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_spawn_timer_timeout() -> void:
	print("Spawn Enemy")
	var enemy = enemy_scene.instantiate()
	
	var spawn_position = Vector2(
		randf_range(50, 1100),
		randf_range(50, 600)
	)
	
	while spawn_position.distance_to(player.position) < MIN_SPACE_DISTANCE:
		spawn_position = Vector2(
			randf_range(50, 1100),
			randf_range(50, 600)
		)	
	
	enemy.position = spawn_position
	
	add_child(enemy)
