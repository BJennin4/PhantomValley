extends Control

@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false
var file_name = " "

func _ready():
	$dialogue_box.visible = false
	
func start(ghostName):
	if d_active:
		return
	d_active = true
	$dialogue_box.visible = true
	set_dialogue_option(ghostName)
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func set_dialogue_option(ghostName):
	#Ghost One
	if ghostName == "Ghost One" && AutoloadVariables.has_quest_item[0] == false:
		file_name = "res://characters/npc/ghost/dialogue/ghost1_dialogue1.json"
	if ghostName == "Ghost One" && AutoloadVariables.has_quest_item[0] == true:
		file_name = "res://characters/npc/ghost/dialogue/ghost1_dialogue2.json"
	#Ghost Two
	if ghostName == "Ghost Two" && AutoloadVariables.has_quest_item[1] == false:
		file_name = "res://characters/npc/ghost/dialogue/ghost2_dialogue1.json"
	if ghostName == "Ghost Two" && AutoloadVariables.has_quest_item[1] == true:
		file_name = "res://characters/npc/ghost/dialogue/ghost2_dialogue2.json"
	#Ghost Three
	if ghostName == "Ghost Three" && AutoloadVariables.has_quest_item[2] == false:
		file_name = "res://characters/npc/ghost/dialogue/ghost3_dialogue1.json"
	if ghostName == "Ghost Three" && AutoloadVariables.has_quest_item[2] == true:
		file_name = "res://characters/npc/ghost/dialogue/ghost3_dialogue2.json"
	#Ghost Four	
	if ghostName == "Ghost Four" && AutoloadVariables.has_quest_item[3] == false:
		file_name = "res://characters/npc/ghost/dialogue/ghost4_dialogue1.json"
	if ghostName == "Ghost Four" && AutoloadVariables.has_quest_item[3] == true:
		file_name = "res://characters/npc/ghost/dialogue/ghost4_dialogue2.json"
	#Ghost Five	
	if ghostName == "Ghost Five" && AutoloadVariables.has_quest_item[4] == false:
		file_name = "res://characters/npc/ghost/dialogue/ghost5_dialogue1.json"
	if ghostName == "Ghost Five" && AutoloadVariables.has_quest_item[4] == true:
		file_name = "res://characters/npc/ghost/dialogue/ghost5_dialogue2.json"
		
func load_dialogue():
	var file = FileAccess.open(file_name, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		AutoloadVariables.ghost_animation_lock = false
		d_active = false
		$dialogue_box.visible = false
		return 
		
	$dialogue_box/Name.text = dialogue[current_dialogue_id]["name"]
	$dialogue_box/Text.text = dialogue[current_dialogue_id]["text"]

func _on_timer_timeout():
	if !d_active:
		return
	next_script()
		
