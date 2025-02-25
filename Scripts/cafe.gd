
	
extends Node2D

@onready var label = $Label  # Label for messages
@onready var counter = $Counter  # Counter image to move out
@onready var cafe = self  # Since this script is attached to "Cafe", use `self`

var counter_target_y = 800  # Adjust this to move the counter fully out of the scene
var target_x = 470  # The stopping position
var customer  # Store customer globally
var employee

func spawn_customer():

	var customer_scene = load("res://Sprites/Customer.tscn")
	customer = customer_scene.instantiate()
	
	#var employee_scene = load("res://Sprites/Employee.tscn")
	#employee = employee_scene.instantiate()
	
	cafe.add_child(customer)
	#cafe.add_child(employee)

	customer.position = Vector2(-200, 800)  
	#employee.position = Vector2

	var customer_sprite = customer.get_node_or_null("AnimatedSprite2D")

	if customer_sprite:
		customer_sprite.play("Walk")  # Start walking animation
	else:
		print("ERROR: AnimatedSprite2D not found in Player.tscn!")
		return

	var tween = create_tween()
	tween.tween_property(customer, "position:x", target_x, 3.0).set_trans(Tween.TRANS_LINEAR)

	await tween.finished

	customer_sprite.play("Idle")

	label.visible = true
	label.text = "Taking order..."

	await get_tree().create_timer(2.0).timeout

	label.text = "Time to prepare the order!"

	await get_tree().create_timer(2.0).timeout

	get_tree().change_scene_to_file("res://scenes/Step1.tscn")

func _ready():
	spawn_customer()
