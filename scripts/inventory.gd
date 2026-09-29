extends Node
var coins = 0
var spikes = 0
var rockets = 0
var weights = 0

var bullets = [1333]

func add_bullet(id):
	bullets.push_back(id)

func add_coins(value):
	coins += value

func add_spikes(value):
	spikes += value

func add_rockets(value):
	rockets += value

func add_weights(value):
	weights += value

func reset():
	coins = 0
	spikes = 0
	rockets = 0
	weights = 0
	bullets = [1333]
