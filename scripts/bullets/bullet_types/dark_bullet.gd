extends Bullet

func _process(delta):
	var velocity = Vector2(speed, 0).rotated(rotation)
	
	position.x += velocity.x * delta
	position.y += velocity.y * delta
