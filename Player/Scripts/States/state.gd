class_name State extends Node

static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Ustala, co się dzieje z graczem w tym stanie
func Enter() -> void:
	pass

## Ustala, co się dzieje przy wyjściu ze stanu
func Exit() -> void:
	pass
	
func Process( _delta: float ) -> State:
	return null
	
func Physics( _delta: float ) -> State:
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null
	
	
