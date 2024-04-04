extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -200.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var all_interactions = []
@onready var interact_label = $"interaction_components/InteractLabel"

func _ready():
	update_interactions()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	# Handle interact
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		

	move_and_slide()
	update_animation()
	update_facing_direction()
	

	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run_right")
		else:
			animated_sprite.play("idle")
			
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		


# Interaction Methods

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0,area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	
	
func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else: 
		interact_label.text = ""
		
func execute_interaction():
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"print_text" : print(current_interaction.interact_value)
