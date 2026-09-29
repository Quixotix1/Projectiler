class_name Bullet

extends Node2D

var speed : float
var scale_mod : float
var damage : float
var damage_mod : float

var bullet_number: int

func create(id: int, i: int):
	scale_mod = ((float(str(id).substr(1, 1)) - 3.0) / 4.0) + 1.0
	damage_mod = ((float(str(id).substr(2, 1)) - 3.0) / 5.0) + 1.0
	damage = (id / 1000 - 1) * 10 + (upgrade.BASE_DAMAGE + upgrade.damage_level * 2) * damage_mod
	speed = (float(str(id).substr(3, 1)) - 3.0) * 50 + upgrade.BASE_BULLET_SPEED + upgrade.bullet_speed_level * 50
	
	bullet_number = i
	
	set_scale(Vector2(scale_mod + upgrade.size_level * 0.1, scale_mod + upgrade.size_level * 0.1))

func _on_destruction_timer_timeout():
	self.queue_free()
