extends Node
const SAVE_PATH := "user://save_game.json"
var state := {
    "player_name": "Player",
    "selected_province": "prov_1",
    "skills": [],
    "controlled_chars": [],
    "suspicion": 0
}
func _ready():
    if FileAccess.file_exists(SAVE_PATH):
        state = load_game()
func save_game():
    var json_text = JSON.print(state)
    var f = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.WRITE)
    if f == null:
        push_error("Failed to open save file for writing.")
        return false
    f.store_string(json_text)
    f.close()
    return true
func load_game():
    var f = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.READ)
    if f == null:
        push_error("Failed to open save file for reading.")
        return {}
    var text = f.get_as_text()
    f.close()
    var res = JSON.parse_string(text)
    if typeof(res) == TYPE_DICTIONARY:
        return res
    if res.has("result"):
        return res["result"]
    return {}
