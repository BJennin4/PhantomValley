extends Panel

@onready var slot_display: Sprite2D = $CenterContainer/Panel/slot_display

func update(item: inv_item):
	if !item:
		slot_display.visible = false
	else:
		slot_display.visible = true
		slot_display.texture = item.texture
