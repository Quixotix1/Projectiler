extends Node

var round_number = 1
var high_score = 0

func progress_round():
	round_number += 1

func reset():
	round_number = 1

func update_score():
	high_score = round_number if round_number > high_score else high_score
