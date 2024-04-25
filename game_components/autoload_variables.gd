# Singleton (Autoload) script for global variables,
# You can access the directory through project -> project settings -> Autoload

extends Node

var quest_mode = false #Sets quest mode for visual effects and dialogue
var has_quest_item = [false, false, false, false, false] # To ensure user is bringing the correct quest item back 
var ghosts_completed = [false, false, false, false, false] # To track which ghosts are completed

var ghost_animation_lock = false #Used to lock animation state on player during ghost dialogue
var last_talked_to_ghost = -1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

	
