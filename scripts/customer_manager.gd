extends Node2D

@onready var speech_bubble = $SpeechBubble

@onready var customer_sprite = $AnimatedSprite2D

@onready var recipe_label = $RecipeBox/Label


var customers = [
	preload("res://Player/Player.tscn"),
]

func show_speech_bubble():
	speech_bubble.visible = true

func show_recipe():
	var possible_ingredients = ["Milk", "Sugar", "Flowers", "Ice", "Boba", "Honey"]

	var recipe = []
	
	while recipe.size() < 3:
		var ingredient = possible_ingredients.pick_random()
		if ingredient not in recipe:
			recipe.append(ingredient)
	
	recipe_label.text = "Order:\n" + "\n".join(recipe)


func spawn_customer():
	# Pick a random customer scene
	var customer_scene = customers.pick_random()
	var customer = customer_scene.instantiate()
	add_child(customer)
	
	# Start position (off-screen left)
	customer.position = Vector2(-200, 500)  # Adjust Y based on where your floor is
	customer_sprite.play("walk")

	# Move customer to center
	var tween = create_tween()
	tween.tween_property(customer, "position:x", 400, 2).set_trans(Tween.TRANS_LINEAR)
	
	# When done walking, switch to idle animation
	await tween.finished
	customer_sprite.play("idle")

	# Show speech bubble
	show_speech_bubble()
	
func _ready():
	spawn_customer()
	show_speech_bubble()
	show_recipe()
