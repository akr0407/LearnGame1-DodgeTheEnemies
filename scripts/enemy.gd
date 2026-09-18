extends CharacterBody2D

const SPEED = 100

var player

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	#print("Players found: ", players.size())
	
	if players.size() > 0:
		player = players[0]

func _physics_process(delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		
		#print("Direction: ", direction, " | Velocity: ", velocity)
		
		move_and_slide()
