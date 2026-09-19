extends Node2D

@onready var player = $Player
@onready var health_label = $UI/HealthLabel
@onready var game_over_panel = $UI/GameOverPanel
@onready var survival_label = $UI/TimeLabel
@onready var final_time_label = $UI/GameOverPanel/FinalTimeLabel
@onready var high_score_label = $UI/HighScoreLabel

var enemy_scene = preload("res://scenes/enemy.tscn")
var spawn_interval = 3
var difficulty_timer = 0
var survival_time = 0
var game_over = false

const MIN_SPACE_DISTANCE = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EnemySpawner/SpawnTimer.wait_time = spawn_interval
	$EnemySpawner/SpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_over:
		return
		
	health_label.text = "Health: " + str(player.health) + " / 100"
	
	survival_time += delta
	survival_label.text = "Time: " + str(int(survival_time))
	
	if int(survival_time) > GameData.high_score:
		GameData.high_score = int(survival_time)
		GameData.save_game()
	
	high_score_label.text = "High Score: " + str(int(GameData.high_score))
	
	difficulty_timer += delta
	
	if difficulty_timer >= 5.0:
		difficulty_timer = 0.0
		
		spawn_interval -= 0.25
		spawn_interval = max(spawn_interval, 0.75)
		
		$EnemySpawner/SpawnTimer.wait_time = spawn_interval

func _on_player_died() -> void:
	game_over = true
	print("Game Over")
	final_time_label.text = "Survived: " + str(int(survival_time)) + " seconds"
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
