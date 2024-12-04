class_name Decetable extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"


@export var condition: String

const Balloon = preload("res://dialogue/balloon.tscn")

signal DialogStarted
signal DialogFinished



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialog_finished)
	body_entered.connect(_player_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialog_finished(resource: DialogueResource):
	PlayerManager.player._on_dialogue_finished()

func _player_entered(_p: Node2D) -> void:
	print("Wszedłeś")
	var condition_met = GameState.le_dict.get(condition)
	if condition_met == null:
		print("Nie znaleziono w słowniku klucza: ", condition)
		return
	
	if !condition_met:
		print("Nie spełniono wymagań")
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		
		balloon.start(dialogue_resource, dialogue_start)
		PlayerManager.player._on_dialog_started()
	
