extends Node2D

@onready var background = $Background  # Reference the TextureRect
@onready var exit_btn = $ExitBtn  # Restart button

# Dictionary to map stars to background images
var backgrounds = {
	0: preload("res://Assets/StarRating/0.png"),
	1: preload("res://Assets/StarRating/1.png"),
	2: preload("res://Assets/StarRating/2.png"),
	3: preload("res://Assets/StarRating/3.png")
}

func _ready():
	var stars = GameManager.total_stars  # Get the total stars

	# Ensure stars are between 0 and 3
	stars = clamp(stars, 0, 3)

	# Set the background image based on stars earned
	background.texture = backgrounds[stars]

	# Resize the background to fit the screen
	resize_background()

func resize_background():
	background.size = get_viewport_rect().size  # Set background size to match screen size

func _on_exit_btn_pressed():
	GameManager.reset_stars()  # Reset the star count
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")  # Go back to main menu
