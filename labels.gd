extends VBoxContainer
@onready var character_body_3d = $"../../../../CharacterBody3D"

@onready var current = $Current
@onready var saved = $Saved

func _process(delta):
	if character_body_3d:
		# Display the player's current position
		current.text = "Current Position: " + str(character_body_3d.global_position)

	# Check if we have saved player data
	var data = SaveSystem.current_data.get("player", null)
	if data and data.has("position"):
		saved.text = "Saved Position: " + str(data.position)
	else:
		saved.text = "Saved Position: No data"
