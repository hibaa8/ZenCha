#extends Node2D
#
#@onready var animated_background = $AnimatedBackground  # Full pouring animation
#@onready var feedback_label = $Label  # Displays result message
#
#var total_frames = 18  # Total frames in the animation
#var current_frame = 0  # Current animation frame
#var pour_active = false  # Is the user holding to pour?
#var stars_earned = 0  # Tracks player success
#var frame_timer = 0.0  # Tracks time for frame update
#var frame_interval = 0.2  # Time to move to next frame (0.25 sec)
#
#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print('pressed!')
		#start_pouring()
	#elif event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print('not pressed!')
		#stop_pouring()
#
#func start_pouring():
	#pour_active = true
	#frame_timer = 0  # Reset timer when pouring starts
#
#func stop_pouring():
	#pour_active = false
	#evaluate_result()  # Check if the player poured correctly
#
#func _process(delta):
	#if pour_active:
		#frame_timer += delta
		#if frame_timer >= frame_interval:  # Move to next frame every 0.2 sec
			#frame_timer = 0  # Reset timer
			#if current_frame < total_frames - 1:  # Prevent going over max frames
				#current_frame += 1
				#animated_background.frame = current_frame  # Update animation frame
#
#func evaluate_result():
	#if current_frame <= 12:
		#feedback_label.text = "Too little!"
	#elif current_frame in [13, 14]:
		#feedback_label.text = "Good job!"  # Correct pour
		#stars_earned += 1
	#else:
		#feedback_label.text = "Overflowed!"
#
	#feedback_label.visible = true  # Show result message
#
	## Wait 1.5 seconds, then move to Step2
	#await get_tree().create_timer(2).timeout
	#get_tree().change_scene_to_file("res://Scenes/Step2.tscn")


extends Node2D

@onready var animated_background = $AnimatedBackground  # Full pouring animation
@onready var feedback_label = $Label  # Displays result message

var total_frames = 18  # Total frames in the animation
var current_frame = 0  # Current animation frame
var pour_active = false  # Is the user holding to pour?
var frame_timer = 0.0  # Tracks time for frame update
var frame_interval = 0.2  # Time to move to next frame (0.2 sec)

# These values will change per step (set in Inspector)
@export var correct_frame_min: int = 14  # Start of perfect pour range
@export var correct_frame_max: int = 15  # End of perfect pour range
@export var next_step_scene: String ="res://scenes/Shake.tscn" # Next scene path

func _input(event):
	# Detect both touch and mouse click
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		start_pouring()
	
	elif (event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		stop_pouring()

func start_pouring():
	pour_active = true
	frame_timer = 0  # Reset timer when pouring starts
func stop_pouring():
	pour_active = false
	evaluate_result()  # Check if the player poured correctly

func _process(delta):
	if pour_active:
		frame_timer += delta
		if frame_timer >= frame_interval:  # Move to next frame every 0.2 sec
			frame_timer = 0  # Reset timer
			if current_frame < total_frames - 1:  # Prevent going over max frames
				current_frame += 1
				animated_background.frame = current_frame  # Update animation frame
				
func evaluate_result():
	if current_frame < correct_frame_min:
		feedback_label.text = "Too little!"
	elif current_frame >= correct_frame_min and current_frame <= correct_frame_max:
		feedback_label.text = "Good job!"  # Correct pour
		GameManager.add_star()  # Increment total stars
		print('star added!')
	else:
		feedback_label.text = "Overflowed!"

	feedback_label.visible = true  # Show result message

	# Wait 1.5 seconds, then move to the next step
	await get_tree().create_timer(1.5).timeout
	if next_step_scene != "":
		get_tree().change_scene_to_file(next_step_scene)
