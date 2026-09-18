extends CharacterBody2D

const SPEED = 300.0
var health = 100

func take_damage(amount):
	health -= amount
	print("Player health: ", health)

func _ready():
	take_damage(10)
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * SPEED
	move_and_slide()
