extends Node2D

func _ready():
	$reload_speed.set_wait_time(upgrade.BASE_RELOAD_SPEED / (1 + upgrade.reload_level * 0.2))

func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		if $reload_speed.time_left == 0:
			for i in range(upgrade.num_bullets_level):
				var b = bullet_factory.create(upgrade.current_bullet_id, i)
				b.position = $sprite.global_position
				b.rotation = (
					rotation if i == 0
					else deg_to_rad(rotation_degrees + 10 * (i / 2)) if i % 2 == 0
					else deg_to_rad(rotation_degrees - 10 * (1 + i / 2))
				)
				get_parent().get_parent().add_child(b)
			$reload_speed.start()
