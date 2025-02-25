extends Node

#@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer2D
#
#func _ready():
#
	#if music_player == null:
		#print("ERROR: AudioStreamPlayer node not found in MusicManager!")
		#return
		#
	#if not music_player.playing:
		#music_player.play()  # Start playing music
#
	## Make sure this node persists across scenes
	#set_process(false)  # It doesn’t need to process per frame
#
#func _on_music_finished():
	#music_player.play()  # Restart music when it finishes
