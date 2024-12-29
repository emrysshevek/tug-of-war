extends Node

# Interjection format:
# [<text: String>, <current_side: int>, <last_winner: int>]
# var phase1_setup = [
# 	{
# 		"values": {
# 			[
# 				"Light: Where "
# 			]
# 		}
# 	}
# ]
var phase1 := [
	{
		"values": [
			"I keep my place full of all the cutest things. I'm sure you'll love it!",
			"I heard Darkness has "
		]
	},
	{
		"current_side": -1, "last_winner": -1, "current_winner": -1,
		"values": [
			"You're so close! Keep going!",
			"You're so bright I can hardly look at you!",
			"Just a bit more!",
			"My bows are going to look adorable on you!",
			"Oooh this is so exciting!"
		]
	},
	{
		"current_side": 1, "last_winner": -1,
		"values": [
			"That's right, I'm going to take good care of you.",
			"I'll save you no matter what it takes.",
			"Why are you making this so difficult?"
		]
	},
]
var phase1_available = phase1
