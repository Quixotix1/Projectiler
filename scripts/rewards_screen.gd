extends Control
var round

func _ready():
	round = round_tracker.round_number
	var coins = ceili(randf_range(0.5, 2.5) * round)
	var spikes = ceili(randf_range(0, 0.5) * round)
	var rockets = ceili(randf_range(0, 0.2) * round)
	var weights = 1
	$coin_count.set_text("* " + str(coins))
	$spikes_count.set_text("* " + str(spikes))
	$rockets_count.set_text("* " + str(rockets))
	$weights_count.set_text("* " + str(weights))
	inventory.add_coins(coins)
	inventory.add_spikes(spikes)
	inventory.add_rockets(rockets)
	inventory.add_weights(weights)
	
	if randi_range(0, 1) == 1:
		var bullet_name : String
		var bullet_id = 0
		
		# declare size
		var size_mod = randf_range(0, 1)
		if size_mod < 0.1:
			bullet_id += 100
			bullet_name = "tiny "
		elif size_mod < 0.3:
			bullet_id += 200
			bullet_name = "small "
		elif size_mod < 0.7:
			bullet_id += 300
		elif size_mod < 0.9:
			bullet_id += 400
			bullet_name = "large "
		else:
			bullet_id += 500
			bullet_name = "massive "
		
		# declare damage
		var damage_mod = randf_range(0, 1)
		if damage_mod < 0.1:
			bullet_id += 10
			bullet_name += "puny "
		elif damage_mod < 0.3:
			bullet_id += 20
			bullet_name += "weak "
		elif damage_mod < 0.6:
			bullet_id += 30
		elif damage_mod < 0.8:
			bullet_id += 40
			bullet_name += "spiky "
		elif damage_mod < 0.95:
			bullet_id += 50
			bullet_name += "powerful "
		else:
			bullet_id += 60
			bullet_name += "almighty "
		
		# declare speed
		var speed_mod = randf_range(0, 1)
		if speed_mod < 0.1:
			bullet_id += 1
			bullet_name += "sluggish "
		elif speed_mod < 0.3:
			bullet_id += 2
			bullet_name += "slow "
		elif speed_mod < 0.7:
			bullet_id += 3
		elif speed_mod < 0.9:
			bullet_id += 4
			bullet_name += "fast "
		else:
			bullet_id += 5
			bullet_name += "blistering "
		
		# declare rarity
		var rarity = randf_range(0, 1)
		if rarity < 0.4:
			bullet_id += 1000
			bullet_name += "bullet"
		elif rarity < 0.7:
			bullet_id += 2000
			bullet_name += "fire bullet"
		elif rarity < 0.85:
			bullet_id += 3000
			bullet_name += "dark bullet"
		elif rarity < 0.95:
			bullet_id += 4000
			bullet_name += "golden bullet"
		elif rarity < 0.99:
			bullet_id += 5000
			bullet_name += "super bullet"
		else:
			bullet_id += 6000
			bullet_name += "god bullet"
		
		if !inventory.bullets.has(bullet_id):
			$extra_drops.set_visible(true)
			inventory.add_bullet(bullet_id)
			$extra_drops.set_text(bullet_name + " dropped!")

func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://scenes/upgrade_screen.tscn")
