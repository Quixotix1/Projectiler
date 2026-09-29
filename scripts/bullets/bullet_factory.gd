extends Node

var bullets = []

# load all bullets
func _ready() -> void:
	bullets.push_back(load("res://scenes/bullets/basic_player_bullet.tscn"))
	bullets.push_back(load("res://scenes/bullets/fire_bullet.tscn"))
	bullets.push_back(load("res://scenes/bullets/dark_bullet.tscn"))
	bullets.push_back(load("res://scenes/bullets/golden_bullet.tscn"))
	bullets.push_back(load("res://scenes/bullets/super_bullet.tscn"))
	bullets.push_back(load("res://scenes/bullets/god_bullet.tscn"))

func create(id: int, i: int):
	var bullet = bullets[id/1000-1].instantiate()
	bullet.create(id, i)
	return bullet
