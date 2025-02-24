extends Node2D
#
#@onready var customer_sprite = $World/Player/AnimatedSprite2D
#
#@onready var label = $World/Label  # Label node for messages
#@onready var counter = $World/Counter  # Counter image to move out
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
	## Move the counter downward out of the scene
	#move_counter_out()
	#
	##change to the matcha making scene
	#get_tree().change_scene_to_file("res://scenes/CookingBase.tscn")
	#
#func move_counter_out():
	#var counter_tween = create_tween()
	#counter_tween.tween_property(counter, "position:y", counter_target_y, 2.0).set_trans(Tween.TRANS_LINEAR)
	#
	#
#func _ready():
	#spawn_customer()
