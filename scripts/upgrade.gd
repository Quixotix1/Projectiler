extends Node

const BASE_SIZE = 1.0
var size_level = 1
const BASE_HEALTH = 20.0
var health_level = 1
const BASE_SPEED = 150.0
var speed_level = 1
const BASE_RELOAD_SPEED = 1.0
var reload_level = 1
const BASE_BULLET_SPEED = 150.0
var bullet_speed_level = 1
const BASE_DAMAGE = 8.0
var damage_level = 1
var num_bullets_level = 1

var current_bullet_id = 1333

func set_bullet_id(id):
	current_bullet_id = id

func reset():
	size_level = 1
	health_level = 1
	speed_level = 1
	reload_level = 1
	bullet_speed_level = 1
	damage_level = 1
	num_bullets_level = 3
	current_bullet_id = 2333
