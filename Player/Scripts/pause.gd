extends Player

@onready var pause_menu = $Camera2D/PauseMenu
var paused = false


func _process(delta: float):
	if Input.is_action_just_pressed("pause"):
		if PlayerManager.player.can_pause:
			pauseMenu()
		else:
			print("Nie można teraz pauzować")
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		get_tree().paused = true
		#Engine.time_scale = 0
	
	paused =! paused
