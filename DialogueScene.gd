extends Control
@onready var portrait = $CharPortrait
@onready var dlg = $DialogueVBox/DialogueLabel
@onready var input = $DialogueVBox/InputLine
@onready var send = $DialogueVBox/SendBtn
@onready var back = $BackBtn
var ai = null
var target = ''
func _ready():
    send.connect('pressed', Callable(self, '_on_send'))
    back.connect('pressed', Callable(self, '_on_back'))
    target = SaveManager.state.get('current_target','')
    ai = load('res://scripts/ai_engine.gd').new()
    _load_char()
func _load_char():
    var provinces = load('res://data/provinces.json').provinces
    for p in provinces:
        for c in p.characters:
            if c.id == target:
                if c.image != '':
                    var tex = load('res://%s' % c.image)
                    if tex:
                        portrait.texture = tex
                dlg.text = 'تحية، اسمي %s. اكتب شيء لنتكلم.' % c.name
                return
func _on_send():
    var t = input.text.strip()
    if t == '': return
    var r = ai.get_reply_for(t, target)
    dlg.text = r
    input.text = ''
func _on_back():
    get_tree().change_scene_to_file('res://scenes/ProvinceScene.tscn')
