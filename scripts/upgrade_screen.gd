extends Control

var size_cost : int
var hp_cost : int
var movement_cost : int
var reload_cost : int
var bspeed_cost : int
var damage_cost : int
var nbullets_cost : int

func _ready():
	update()

func base_cost(level):
	return fibonacci_calculation(level)[0]

# code from nayuki.io
func fibonacci_calculation(n):
	if n == 0:
		return [0, 1]
	else:
		var a = fibonacci_calculation(floori(n / 2))
		var b = a[0] * (a[1] * 2 - a[0])
		var c = a[0] * a[0] + a[1] * a[1]
		if n % 2 == 0:
			return [b, c]
		else:
			return [c, b + c]

func update():
	# player upgrades
	size_cost = base_cost(upgrade.size_level)
	hp_cost = base_cost(upgrade.health_level) * 1.5
	movement_cost = base_cost(upgrade.speed_level)
	
	$player_upgrades/size_upgrade.set_text(str(size_cost))
	$player_upgrades/hp_upgrade.set_text(str(hp_cost))
	$player_upgrades/movement_upgrade.set_text(str(movement_cost))
	
	$player_upgrades/size_level_indicator.set_text("Level " + str(upgrade.size_level))
	$player_upgrades/hp_level_indicator.set_text("Level " + str(upgrade.health_level))
	$player_upgrades/movement_level_indicator.set_text("Level " + str(upgrade.speed_level))
	
	# gun upgrades
	reload_cost = base_cost(upgrade.reload_level)
	bspeed_cost = base_cost(upgrade.bullet_speed_level + 2) * 0.8
	damage_cost = base_cost(upgrade.damage_level)
	nbullets_cost = base_cost(upgrade.num_bullets_level + 1) * 3
	
	$gun_upgrades/reload_upgrade.set_text(str(reload_cost))
	$gun_upgrades/bspeed_upgrade.set_text(str(bspeed_cost))
	$gun_upgrades/damage_upgrade.set_text(str(damage_cost))
	$gun_upgrades/nbullets_upgrade.set_text(str(nbullets_cost))
	
	$gun_upgrades/reload_level_indicator.set_text("Level " + str(upgrade.reload_level))
	$gun_upgrades/bspeed_level_indicator.set_text("Level " + str(upgrade.bullet_speed_level))
	$gun_upgrades/damage_level_indicator.set_text("Level " + str(upgrade.damage_level))
	$gun_upgrades/nbullets_level_indicator.set_text("Level " + str(upgrade.num_bullets_level))
	
	# bullet upgrades
	$bullet_upgrades/bullet_inventory.clear()
	for i in inventory.bullets:
		$bullet_upgrades/bullet_inventory.add_item(parse_bullet_name(i))
	
	$images/Bullet.set_texture(
		load("res://images/bullets/bullet.png") if upgrade.current_bullet_id / 1000 == 1
		else load("res://images/bullets/fire_bullet.png") if upgrade.current_bullet_id / 1000 == 2
		else load("res://images/bullets/dark_bullet.png") if upgrade.current_bullet_id / 1000 == 3
		else load("res://images/bullets/golden_bullet.png") if upgrade.current_bullet_id / 1000 == 4
		else load("res://images/bullets/super_bullet.png") if upgrade.current_bullet_id / 1000 == 5
		else load("res://images/bullets/god_bullet.png")
		)
	
	$inventory/coin_count.set_text("*" + str(inventory.coins))
	$inventory/rocket_count.set_text("*" + str(inventory.rockets))
	$inventory/spike_count.set_text("*" + str(inventory.spikes))
	$inventory/weight_count.set_text("*" + str(inventory.weights))

func parse_bullet_name(id):
	var rarity = id / 1000
	var scale_mod = float(str(id).substr(1, 1))
	var damage_mod = float(str(id).substr(2, 1))
	var speed_mod = float(str(id).substr(3, 1))
	
	var bullet_name : String
	bullet_name = (
		"tiny " if scale_mod == 1
		else "small " if scale_mod == 2
		else "large " if scale_mod == 4
		else "massive " if scale_mod == 5
		else ""
		)
	
	bullet_name += (
		"puny " if damage_mod == 1
		else "weak " if damage_mod == 2
		else "spiky " if damage_mod == 4
		else "powerful " if damage_mod == 5
		else "almighty " if damage_mod == 6
		else ""
		)
	
	bullet_name += (
		"sluggish " if speed_mod == 1
		else "slow " if speed_mod == 2
		else "fast " if speed_mod == 4
		else "blistering " if speed_mod == 5
		else ""
		)
	
	bullet_name += (
		"bullet" if rarity == 1
		else "fire bullet" if rarity == 2
		else "dark bullet" if rarity == 3
		else "golden bullet" if rarity == 4
		else "super bullet" if rarity == 5
		else "god bullet"
		)
	
	return bullet_name

# straight from copilot lmao
func parse_bullet_id(bullet_name: String) -> int:
	var rarity = 0
	var scale_mod = 0
	var damage_mod = 0
	var speed_mod = 0
	
	if "tiny " in bullet_name:
		scale_mod = 1
	elif "small " in bullet_name:
		scale_mod = 2
	elif "large " in bullet_name:
		scale_mod = 4
	elif "massive " in bullet_name:
		scale_mod = 5
	else:
		scale_mod = 3
	
	if "puny " in bullet_name:
		damage_mod = 1
	elif "weak " in bullet_name:
		damage_mod = 2
	elif "spiky " in bullet_name:
		damage_mod = 4
	elif "powerful " in bullet_name:
		damage_mod = 5
	elif "almighty " in bullet_name:
		damage_mod = 6
	else:
		damage_mod = 3
	
	if "sluggish " in bullet_name:
		speed_mod = 1
	elif "slow " in bullet_name:
		speed_mod = 2
	elif "fast " in bullet_name:
		speed_mod = 4
	elif "blistering " in bullet_name:
		speed_mod = 5
	else:
		speed_mod = 3
	
	if "fire bullet" in bullet_name:
		rarity = 2
	elif "dark bullet" in bullet_name:
		rarity = 3
	elif "golden bullet" in bullet_name:
		rarity = 4
	elif "super bullet" in bullet_name:
		rarity = 5
	elif "god bullet" in bullet_name:
		rarity = 6
	else:
		rarity = 1
	
	var id = rarity * 1000 + scale_mod * 100 + damage_mod * 10 + speed_mod
	return id

func _on_size_upgrade_pressed():
	if inventory.coins >= size_cost:
		upgrade.size_level += 1
		inventory.add_coins(-size_cost)
	update()

func _on_hp_upgrade_pressed():
	if inventory.coins >= hp_cost:
		upgrade.health_level += 1
		inventory.add_coins(-hp_cost)
	update()

func _on_movement_upgrade_pressed():
	if inventory.rockets >= movement_cost:
		upgrade.speed_level += 1
		inventory.add_rockets(-movement_cost)
	update()

func _on_round_increment_pressed():
	round_tracker.progress_round()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_reload_upgrade_pressed():
	if inventory.rockets >= reload_cost:
		upgrade.reload_level += 1
		inventory.add_rockets(-reload_cost)
	update()

func _on_bspeed_upgrade_pressed():
	if inventory.rockets >= bspeed_cost:
		upgrade.bullet_speed_level += 1
		inventory.add_rockets(-bspeed_cost)
	update()

func _on_damage_upgrade_pressed():
	if inventory.spikes >= damage_cost:
		upgrade.damage_level += 1
		inventory.add_spikes(-damage_cost)
	update()

func _on_nbullets_upgrade_pressed():
	if inventory.spikes >= nbullets_cost:
		upgrade.num_bullets_level += 1
		inventory.add_spikes(-nbullets_cost)
	update()

func _on_equip_button_pressed():
	var selected_item = $bullet_upgrades/bullet_inventory.get_selected_items()[0]
	var id = parse_bullet_id($bullet_upgrades/bullet_inventory.get_item_text(selected_item))
	upgrade.set_bullet_id(id)
	update()
