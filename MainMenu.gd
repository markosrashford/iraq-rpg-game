extends Control
@onready var btn = $PlayButton
func _ready():
    btn.connect("pressed", Callable(self, "_on_play"))
func _on_play():
    SaveManager.state['player_name'] = "Player"
    get_tree().change_scene_to_file("res://scenes/MapScene.tscn")
