extends Node2D
class_name HealthComponent

@export var immunity_component : Timer
@export var MAX_HEALTH : float
var health : float

func take_damage(damage):
	if immunity_component.is_stopped:
		health -= damage
		if health <= 0:
			get_parent().dead()
		else:
			get_parent().take_damage()
			immunity_component.start()
