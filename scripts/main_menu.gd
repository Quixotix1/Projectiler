extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$high_score_label.set_text("high score: " + str(round_tracker.high_score) + " rounds")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	upgrade.reset()
	inventory.reset()
	round_tracker.reset()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_enemy_guide_button_pressed():
	get_tree().change_scene_to_file("res://scenes/enemy_guide.tscn")

func _on_toggle_music_button_pressed():
	music.stream_paused = !music.stream_paused
