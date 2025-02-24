extends Node2D

@onready var animated_background = $AnimatedBackground  

var total_frames = 18  
var current_frame = 0  
var frame_timer = 0.0  
var frame_interval = 0.1 

var next_step_scene: String = "res://scenes/EndScene.tscn"

func _ready():
	play_shake_animation()

func play_shake_animation():
	# Play the animation automatically without input
	while current_frame < total_frames - 1:
		await get_tree().create_timer(frame_interval).timeout  # Wait per frame
		current_frame += 1
		animated_background.frame = current_frame  # Update animation frame
	
	# After animation finishes, move to next scene
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file(next_step_scene)
