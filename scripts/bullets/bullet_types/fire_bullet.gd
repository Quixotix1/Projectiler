extends Bullet

const HORIZONTAL_MOVEMENT = 800
var direction = 0

func _ready() -> void:
	direction = (
		0 if bullet_number == 0
		else 1 if bullet_number % 2 == 0
		else -1
	)

func _process(delta):
	var time_elapsed = 3 - $destruction_timer.time_left
	var velocity = Vector2(speed, direction * HORIZONTAL_MOVEMENT * time_elapsed * sin(4 * PI * time_elapsed)).rotated(rotation)
	
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	
	print("THIS IS A FIRE BULLET")
