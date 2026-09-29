extends CharacterBody2D

var MAX_SPEED
var speed
var sprite_color
var is_dead = false
var game_over_fade_in = false
var fade_level = 0

func _ready():
	$round_indicator.set_text("round " + str(round_tracker.round_number))
	
	MAX_SPEED = upgrade.BASE_SPEED + 10 * upgrade.speed_level
	speed = MAX_SPEED
	$health_component.MAX_HEALTH = upgrade.BASE_HEALTH + 5 * upgrade.health_level
	$health_component.health = upgrade.BASE_HEALTH + 5 * upgrade.health_level
	self.set_scale(Vector2(upgrade.BASE_SIZE + upgrade.size_level * 0.1, upgrade.BASE_SIZE + upgrade.size_level * 0.1))
	sprite_color = $sprite.get_modulate()
	$camera.set_zoom(Vector2(4.0 / (upgrade.BASE_SIZE + upgrade.size_level * 0.1), 4.0 / (upgrade.BASE_SIZE + upgrade.size_level * 0.1)))

func _physics_process(delta):
	if !is_dead:
		if speed < MAX_SPEED:
			speed += 5.0
		
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		
		var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		if direction.x:
			velocity.x = direction.x
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		if direction.y:
			velocity.y = direction.y
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
		
		velocity = velocity.normalized() * speed
		
		move_and_slide()
	elif game_over_fade_in:
		if fade_level < 26:
			$game_over_fade.set_color(Color(160.0 / 255.0, 0, 0, fade_level / 255.0))
			fade_level += 1

func take_damage():
	speed = 10.0
	
	# flash black
	$sprite.set_modulate(Color.BLACK)
	await get_tree().create_timer(0.1).timeout
	$sprite.set_modulate(sprite_color)
	
	$health_base/health_bar.size.x = 28.0 * (float($health_component.health) / float($health_component.MAX_HEALTH))

func dead():
	is_dead = true
	$gun.queue_free()
	$health_base.queue_free()
	get_parent().end_game()
	$sprite.set_modulate(Color.BLACK)
	await get_tree().create_timer(0.5).timeout
	$sprite.set_modulate(sprite_color)
	await get_tree().create_timer(0.5).timeout
	$sprite.set_modulate(Color.BLACK)
	await get_tree().create_timer(0.5).timeout
	$sprite.set_modulate(sprite_color)
	await get_tree().create_timer(0.5).timeout
	$sprite.queue_free()
	$round_indicator.queue_free()
	
	game_over_fade_in = true
	await get_tree().create_timer(0.5).timeout
	$game_over_label.set_visible(true)
	$restart_button.set_visible(true)

func show_round_over_label():
	$round_over_label.set_visible(true)

func hide_round_over_label():
	$round_over_label.set_visible(false)

func _on_restart_button_pressed():
	round_tracker.update_score()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
