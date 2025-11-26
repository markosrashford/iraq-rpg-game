extends Node
var data = {}
func _init():
    data = load('res://data/ai_responses.json')
func get_reply_for(user_text: String, target_id: String) -> String:
    var ut = user_text.to_lower()
    var name = ''
    var age = ''
    for c in data.characters_sample:
        if c.id == target_id:
            name = c.name
            age = str(c.age)
            break
    # match by keyword
    for t in data.templates:
        for cond in t.conds:
            if cond != '' and ut.find(cond) != -1:
                var r = t.responses
                return r[int(randf()*r.size())].replace('%NAME%', name).replace('%AGE%', age)
    # default
    var defs = data.templates[-1].responses
    return defs[int(randf()*defs.size())]
