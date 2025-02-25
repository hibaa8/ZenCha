
extends Node2D

@onready var animated_background = $AnimatedBackground  # Full pouring animation
@onready var feedback_label = $Label  # Displays result message

var total_frames = 18  # Total frames in the animation
var current_frame = 0  # Current animation frame
var pour_active = false  # Is the user holding to pour?
var frame_timer = 0.0  # Tracks time for frame update
var frame_interval = 0.2  # Time to move to next frame (0.2 sec)

var correct_frame_min: int = 15  # Start of perfect pour range
var correct_frame_max: int = 16  # End of perfect pour range
var next_step_scene: String ="res://scenes/Step3.tscn" # Next scene path

func _input(event):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		start_pouring()
	
	elif (event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		stop_pouring()

func start_pouring():
	pour_active = true
	frame_timer = 0 
func stop_pouring():
	pour_active = false
	evaluate_result()  

func _process(delta):
	if pour_active:
		frame_timer += delta
		if frame_timer >= frame_interval:  
			frame_timer = 0  # Reset timer
			if current_frame < total_frames - 1: 
				current_frame += 1
				animated_background.frame = current_frame  # Update animation frame
				
func evaluate_result():
	if current_frame < correct_frame_min:
		feedback_label.text = "Too little!"
	elif current_frame >= correct_frame_min and current_frame <= correct_frame_max:
		feedback_label.text = "Good job!"  
		GameManager.add_star() 
		print('star added!')
	else:
		feedback_label.text = "Overflowed!"

	feedback_label.visible = true  

	await get_tree().create_timer(1.5).timeout
	if next_step_scene != "":
		get_tree().change_scene_to_file(next_step_scene)
