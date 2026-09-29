extends Node2D

@export var basic_enemy : PackedScene
@export var spinning_enemy : PackedScene
@export var suicidal_enemy : PackedScene
@export var destroyer_enemy : PackedScene
var enemy_count : int
var round_over : bool
var game_over = false

func _ready():
	round_over = false
	enemy_count = 0
	for i in range(round_tracker.round_number):
		if (i + 1) % 15 == 0:
			var b = destroyer_enemy.instantiate()
			b.position.y = randi_range(-400, 400)
			b.position.x = randi_range(-400, 400)
			if b.position.x >= 0:
				b.position.x += 400 - abs(b.position.y)
			if b.position.x < 0:
				b.position.x -= 400 - abs(b.position.y)
			var enemy_scale = randf_range(4, 4 + round_tracker.round_number * 0.1)
			b.set_scale(Vector2(enemy_scale, enemy_scale))
			b.MAX_SPEED = 60.0
			add_child(b)
			enemy_count += 1
		elif i < 25 && (i + 1) % 5 == 0:
			var b = spinning_enemy.instantiate()
			b.position.y = randi_range(-400, 400)
			b.position.x = randi_range(-400, 400)
			if b.position.x >= 0:
				b.position.x += 400 - abs(b.position.y)
			if b.position.x < 0:
				b.position.x -= 400 - abs(b.position.y)
			var enemy_scale = randf_range(1, 1 + round_tracker.round_number * 0.05)
			b.set_scale(Vector2(enemy_scale, enemy_scale))
			add_child(b)
			enemy_count += 1
		elif i < 30 && (i + 1) % 7 == 0:
			var b = suicidal_enemy.instantiate()
			b.position.y = randi_range(-400, 400)
			b.position.x = randi_range(-400, 400)
			if b.position.x >= 0:
				b.position.x += 400 - abs(b.position.y)
			if b.position.x < 0:
				b.position.x -= 400 - abs(b.position.y)
			var enemy_scale = randf_range(1, 1 + round_tracker.round_number * 0.2)
			b.set_scale(Vector2(enemy_scale, enemy_scale))
			add_child(b)
			enemy_count += 1
		elif i < 20:
			var b = basic_enemy.instantiate()
			b.position.y = randi_range(-400, 400)
			b.position.x = randi_range(-400, 400)
			if b.position.x >= 0:
				b.position.x += 400 - abs(b.position.y)
			if b.position.x < 0:
				b.position.x -= 400 - abs(b.position.y)
			var enemy_scale = randf_range(1, 1 + round_tracker.round_number * 0.05)
			b.set_scale(Vector2(enemy_scale, enemy_scale))
			b.MAX_SPEED = randf_range(100, 100 + round_tracker.round_number * 5)
			add_child(b)
			enemy_count += 1
		

func remove_enemy():
	if !game_over:
		enemy_count -= 1
		if enemy_count == 0:
			round_end()

func end_game():
	game_over = true
	for c in get_children():
		if c.is_in_group("enemy") || c.is_in_group("boundary") || c.is_in_group("bullet"):
			c.queue_free()

func round_end():
	if !game_over:
		round_over = true
		$player.show_round_over_label()
		await get_tree().create_timer(2).timeout
		$player.hide_round_over_label()	
		get_tree().change_scene_to_file("res://scenes/rewards_screen.tscn")

func _process(delta):
	pass
