extends Control
@onready var vbox = $ProvincesVBox
func _ready():
    var provinces = load('res://data/provinces.json').provinces
    for p in provinces:
        var b = Button.new()
        b.text = p.name
        b.rect_min_size = Vector2(300,48)
        vbox.add_child(b)
        b.connect('pressed', Callable(self, '_on_prov'), [p.id])
func _on_prov(pid):
    SaveManager.state['selected_province'] = pid
    get_tree().change_scene_to_file('res://scenes/ProvinceScene.tscn')
