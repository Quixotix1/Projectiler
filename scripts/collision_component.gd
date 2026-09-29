extends Area2D

@export var health_component : HealthComponent

func _on_area_entered(area):
	if area.is_in_group("player_projectile") and get_parent().is_in_group("enemy"):
		health_component.take_damage(area.get_parent().damage)
		area.get_parent().queue_free()
	elif area.is_in_group("enemy_projectile") and get_parent().is_in_group("player"):
		health_component.take_damage(area.get_parent().damage)
		area.get_parent().queue_free()
	elif area.is_in_group("enemy") and get_parent().is_in_group("player"):
		health_component.take_damage(area.get_parent().damage)
		area.get_parent().dead()
	
