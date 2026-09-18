extends CharacterBody2D

const SPEED = 100

var player
var player_in_range = false

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
		player_in_range = true
		$DamageTimer.start()
		
	#print("Something entered the enemy area")
	#print("Body: ", body.name)


func _on_damage_timer_timeout() -> void:
	print("attack")
	if player_in_range:
		player.take_damage(10)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		$DamageTimer.stop()
