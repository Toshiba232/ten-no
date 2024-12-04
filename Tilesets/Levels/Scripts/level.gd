extends Node2D
class_name Level 




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect( _free_level )
	#LevelManager.fight_over.connect(_on_fight_over)
	pass # Replace with function body.


func _on_fight_over(walka_path: String, walka: String):
	#print("Walka zakończona. Szukanie: ", walka_path)
	#for node in get_tree().get_nodes_in_group("Les_Actionables"):
		#if node.fight_path == walka_path:
			#print("O cholera")
			#print("Szukanie tego czegoś: ", walka)
			#if GameState.is_walka_wygrana(walka):
				#print("Walka wygrana")
				#node.post_fight()

	pass


func _free_level() -> void:
	PlayerManager.unparent_player( self )
	queue_free()
	
