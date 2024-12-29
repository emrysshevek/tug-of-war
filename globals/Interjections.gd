extends Node

# Interjection format:
# [<text: String>, <current_side: int>, <current_winner: int>, <last_winner: int>]

var phase1_setup = [
	{
		"values": 
		[
			[
				"Light: I keep my place full of all the cutest things. I'm sure you'd love it!"
			],
			[
				"Dark: Ugh your making a mess of this place"
			]
		]
	},
	{
		"current_side": -1, "last_winner": -1, "current_winner": -1,
		"values": [
			[
				"Light: You're so close! Keep going!",
			],
			[
				"Light: You're so bright I can hardly look at you!",
			],
			[
				"Light: Just a bit more!",
			],
			[
				"Light: My bows are going to look adorable on you!",
			],
			[
				"Light: Oooh this is so exciting!"
			]
		]
	},
	{
		"current_side": 1, "last_winner": -1,
		"values": [
			[
				"Light: That's right, I'm going to take good care of you.",
			],
			[
				"Light: I'll save you no matter what it takes.",
			],
			[
				"Light: Why are you making this so difficult?"
			]
		]
	},
]

var phase1_timelines = []
var phase1_available: Array

var all_timelines := []

func _ready() -> void:
	for group: Dictionary in phase1_setup:
		for events in group["values"]:
			var timeline = DialogicTimeline.new()
			timeline.events = events
			phase1_timelines.append([timeline, group.get("current_side", 0), group.get("current_winner", 0), group.get("last_winner", 0)])

	all_timelines.append(phase1_timelines)
	phase1_available = phase1_timelines.duplicate()

func play_interjection() -> void:
	var timeline = _select_timeline(all_timelines[Globals.phase - 1])
	if timeline != null:
		Dialogic.start_timeline(timeline)
	
func _select_timeline(timelines: Array) -> DialogicTimeline:
	var allowed = timelines.filter(_filter_correct)
	if len(allowed) > 0:
		return allowed.pick_random()[0]
	return null

func _filter_correct(timeline: Array) -> bool:
	return (
			timeline[1] == 0 or timeline[1] == Globals.current_side
			and timeline[2] == 0 or timeline[2] == sign(Globals.phase_score)
			and timeline[3] == 0 or timeline[3] == Globals.last_winner
	) 