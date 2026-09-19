extends CharacterBody2D

const SPEED = 300.0
var health = 100
signal died

func take_damage(amount):
	health -= amount
	print("Player health: ", health)
	
	$HitSound.play()
	$Sprite2D.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.modulate = Color.WHITE
	
	if health <= 0:
		die()

func die():
	print("Player Died")
	
	set_physics_process(false)
	$Sprite2D.visible = false
	$DamageSound.play()
	
	died.emit()

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * SPEED
	move_and_slide()
