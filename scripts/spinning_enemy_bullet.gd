extends Node2D

@export var speed := 200.0
var damage = 10.0

func _process(delta):
	var velocity = Vector2(speed, 0).rotated(rotation)
	$sprite.rotation_degrees += 5
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	
	if(get_parent().round_over):
		self.queue_free()

func _on_destruction_timer_timeout():
	self.queue_free()
