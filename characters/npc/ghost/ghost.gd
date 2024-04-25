extends CharacterBody2D

var player = "Player"
@export_enum("Ghost One", "Ghost Two", "Ghost Three", "Ghost Four", "Ghost Five") var ghostName
var ghost_name
var ghost_id = 0

func _ready():
	set_ghost()

#Activate quest sequence on collision with ghost dialogue box
func _on_chat_detection_area_body_entered(body):
	#Activates on player collision with orange collison box: begins quest 
	if body.name == player && (AutoloadVariables.quest_mode == false && AutoloadVariables.ghosts_completed[ghost_id] == false): 
		AutoloadVariables.ghost_animation_lock = true
		$Dialogue.start(ghost_name)
		AutoloadVariables.quest_mode = true
		AutoloadVariables.last_talked_to_ghost = ghost_id

	#Activates on player collision with orange col box when Quest mode == true & player has correct ghost item & and ghost is last ghost talked to
	if (body.name == player && AutoloadVariables.quest_mode) \
	&& (AutoloadVariables.has_quest_item[AutoloadVariables.last_talked_to_ghost] \
	&& ghost_id == AutoloadVariables.last_talked_to_ghost):
		AutoloadVariables.ghost_animation_lock = true 
		$Dialogue.start(ghost_name)
		set_ghost_completion()

#Set corresponding ghost ID & Name when enum is selected in inspector
func set_ghost():
	if ghostName == 0:
		ghost_name = "Ghost One"
		ghost_id = 0
	if ghostName == 1:
		ghost_name = "Ghost Two"
		ghost_id = 1
	if ghostName == 2:
		ghost_name = "Ghost Three"
		ghost_id = 2
	if ghostName == 3:
		ghost_name = "Ghost Four"
		ghost_id = 3
	if ghostName == 4:
		ghost_name = "Ghost Five"
		ghost_id = 4

#Set ghost complete, disable quest mode, remove quest item
func set_ghost_completion():
		AutoloadVariables.ghosts_completed[AutoloadVariables.last_talked_to_ghost] = true
		AutoloadVariables.quest_mode = false
		AutoloadVariables.has_quest_item[AutoloadVariables.last_talked_to_ghost] = false
