extends Control

@onready var inv: Inventory = preload("res://game_components/inventory/player.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
			get_tree().paused = false
		else:
			get_tree().paused = true
			open()

func open():
	self.visible = true
	is_open = true

func close():
	visible = false
	is_open = false
