extends CharacterBody2D

@export var bullet : PackedScene
@export var health := 20.0
var MAX_SPEED : float
var speed : float
var damage : int
var is_dead : bool
var sprite_color

func _ready():
	is_dead = false
	$health_component.MAX_HEALTH = health
	$health_component.health = health
	damage = 4 + self.scale.x
	speed = MAX_SPEED
	sprite_color = $sprite.get_modulate()

func _physics_process(delta):
	if speed < MAX_SPEED:
		speed += 1.0
	
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	
	look_at(get_parent().get_child(0).global_position)
	var velocity = Vector2(speed, 0).rotated(rotation)
	
	position.x += velocity.x * delta
	position.y += velocity.y * delta

func take_damage():
	speed = 30.0
	
	# flash black
	$sprite.set_modulate(Color.BLACK)
	await get_tree().create_timer(0.1).timeout
	$sprite.set_modulate(sprite_color)
	
	$health_base/health_bar.size.x = 20.0 * (float($health_component.health) / float($health_component.MAX_HEALTH))

func dead():
	if !is_dead:
		get_parent().remove_enemy()
	is_dead = true
	self.queue_free()

func _on_reload_speed_timeout():
	var b = bullet.instantiate()
	b.position = $sprite.global_position
	b.rotation = rotation
	b.scale = self.scale
	get_parent().add_child(b)
	$reload_speed.start()
