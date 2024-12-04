class_name Actionable extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"


@export var fight_var: String
@export var dialogue_post_fight: String

@export_file("*.tscn") var fight_path

const Balloon = preload("res://dialogue/balloon.tscn")

signal DialogStarted
signal DialogFinished


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialog_finished)
	
	if fight_var != null and !fight_var.is_empty():
		print("Łączenieeeeeeeee: ", fight_var)
		LevelManager.fight_over.connect(_post_fight)	
	if fight_var == "walka_smog" and GameState.smog_moved:
		print("Grzeczny rych")
		politely_move(fight_var)
	elif fight_var == "pryncypalki_zdobyte" and GameState.get_flag_dict("pryncypalki_zdobyte"):
		print("Grzeczny disappear")
		visible = false
	

func action() -> void:
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	
	balloon.start(dialogue_resource, dialogue_start)
	#DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	DialogStarted.emit()

func _on_dialog_finished(resource: DialogueResource):
	DialogFinished.emit()
	
	if fight_var == "walka_smog" and GameState.is_walka_wygrana(fight_var) and !GameState.smog_moved:
		print("Walka wygrana. Smog powinien się ruszyć.")
		politely_move(fight_var)
	elif fight_var == "pryncypalki_zdobyte" and GameState.get_flag_dict("pryncypalki_zdobyte"):
		print("Pryncypałki zdobyte. Coś powinno zniknąć.")
		visible = false
func load_fight():
	print("Ładowanie walki")
	
	
func _post_fight(walka_path: String, walka: String):
	if fight_var != walka:
		return
	
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
		
	balloon.start(dialogue_resource, dialogue_post_fight)

func politely_move(walka: String):
	print("Modulacja czy coś.")
	for node in get_tree().get_nodes_in_group("Les_Actionables"):
		if node.fight_var == walka:
			node.position = node.position - Vector2(-64, 0)
			GameState.smog_moved = true
