extends Node

var high_score = 0 

const  SAVE_PATH = "user://savegame.json"

func _ready() -> void:
	load_game()
	
	
func save_game() -> void:
	var data = {
		"high_score" = high_score
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	if data:
		high_score = data.get("high_score", 0)
