#extends Node2D
#
#
#@onready var customer_sprite = $Player/AnimatedSprite2D
#
#@onready var label = $Label  # Label node for messages
#
#var counter_target_y = 800  # Adjust this to move the counter fully out of the scene
#var customer  # Store customer globally
#var target_x = 480  # The stopping position
#
#func spawn_customer():
	## Load the customer scene
	#var customer_scene = load("res://Player/Player.tscn")
	#customer = customer_scene.instantiate()
	#add_child(customer)
#
	## Start position (off-screen left)
	#customer.position = Vector2(-200, 550)  # Adjust Y based on where your floor is
#
	## Get the AnimatedSprite2D inside the customer scene
	#var customer_sprite = customer.get_node("AnimatedSprite2D")
	#
	#if customer_sprite:
		#customer_sprite.play("walk")  # Start walking animation
	#else:
		#print("ERROR: AnimatedSprite2D not found in Player.tscn!")
		#return
#
	## Create a tween for smooth movement
	#var tween = create_tween()
	#tween.tween_property(customer, "position:x", target_x, 3.0).set_trans(Tween.TRANS_LINEAR)
#
	## Wait for the tween to finish before changing animation
	#await tween.finished
#
	## Switch to idle animation
	#customer_sprite.play("idle")
	#
	## Show label with first message
	#label.visible = true
	#label.text = "Taking order..."
#
	## Wait for 2 seconds
	#await get_tree().create_timer(2.0).timeout
#
	## Change the text on the label
	#label.text = "Time to prepare the order!"
#
	## Wait for another 2 seconds
	#await get_tree().create_timer(2.0).timeout
	#
	##change to the matcha making scene
	#get_tree().change_scene_to_file("res://scenes/Step1.tscn")
	#
	#
#func _ready():
	#spawn_customer()
	
extends Node2D

@onready var label = $Label  # Label for messages
@onready var counter = $Counter  # Counter image to move out
@onready var cafe = self  # Since this script is attached to "Cafe", use `self`

var counter_target_y = 800  # Adjust this to move the counter fully out of the scene
var target_x = 470  # The stopping position
var customer  # Store customer globally
var employee

func spawn_customer():
	# Load the customer scene
	var customer_scene = load("res://Sprites/Customer.tscn")
	customer = customer_scene.instantiate()
	
	#var employee_scene = load("res://Sprites/Employee.tscn")
	#employee = employee_scene.instantiate()
	
	# Add customer to the correct node (Cafe)
	cafe.add_child(customer)
	#cafe.add_child(employee)

	# Set customer position (starting from off-screen left)
	customer.position = Vector2(-200, 800)  
	#employee.position = Vector2

	# Ensure AnimatedSprite2D exists inside the customer scene
	var customer_sprite = customer.get_node_or_null("AnimatedSprite2D")

	if customer_sprite:
		customer_sprite.play("Walk")  # Start walking animation
	else:
		print("ERROR: AnimatedSprite2D not found in Player.tscn!")
		return

	# Create a tween for smooth movement
	var tween = create_tween()
	tween.tween_property(customer, "position:x", target_x, 3.0).set_trans(Tween.TRANS_LINEAR)

	# Wait for the tween to finish before changing animation
	await tween.finished

	# Switch to idle animation
	customer_sprite.play("Idle")

	# Show label with first message
	label.visible = true
	label.text = "Taking order..."

	# Wait for 2 seconds
	await get_tree().create_timer(2.0).timeout

	# Change the text on the label
	label.text = "Time to prepare the order!"

	# Wait for another 2 seconds
	await get_tree().create_timer(2.0).timeout

	# Change to the matcha-making scene
	get_tree().change_scene_to_file("res://scenes/Step1.tscn")

func _ready():
	spawn_customer()
