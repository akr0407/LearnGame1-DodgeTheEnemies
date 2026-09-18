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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	
	if body.is_in_group("player"):
		body.take_damage(10)
		
	print("Something entered the enemy area")
	print("Body: ", body.name)
