extends Node

var save_path = "user://save_game.bin"
var current_data = {}

func _ready():
	if FileAccess.file_exists(save_path):
		load_game()
	else:
		current_data = {
			"player": {
				"position": Vector3(0, 0, 0),
			}
		}

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(current_data)
		file.close()

func load_game():
	if not FileAccess.file_exists(save_path):
		return # No file, use defaults or do nothing

	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var data = file.get_var()
		file.close()

		if typeof(data) == TYPE_DICTIONARY:
			current_data = data
		else:
			push_warning("Loaded data is not a dictionary! Resetting to defaults.")
			_reset_defaults()

func _reset_defaults():
	current_data = {
		"player": {
			"position": Vector3(0, 0, 0)
		}
	}
