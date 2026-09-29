extends CharacterBody2D

@export var bullet : PackedScene
@export var health := 80.0
var damage : int
var is_dead : bool
var sprite_color

func _ready():
	is_dead = false
	$health_component.MAX_HEALTH = health
	$health_component.health = health
	damage = 4 + self.scale.x
	sprite_color = $sprite.get_modulate()

func _physics_process(delta):
	$sprite.set_rotation_degrees($sprite.get_rotation_degrees() + 1)
	$collision_component.set_rotation_degrees($sprite.get_rotation_degrees() + 1)
	$collider.set_rotation_degrees($sprite.get_rotation_degrees() + 1)

func take_damage():
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
	for i in range(4):
		var b = bullet.instantiate()
		b.position = $sprite.global_position
		b.rotation_degrees = $sprite.rotation_degrees + i * 90 + 45
		b.scale = self.scale
		get_parent().add_child(b)
	$reload_speed.start()
