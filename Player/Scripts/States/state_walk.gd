class_name State_Walk extends State

@export var SPEED = 100.0

@onready var idle: State = $"../Idle"

## Ustala, co się dzieje z graczem w tym stanie
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

## Ustala, co się dzieje przy wyjściu ze stanu
func Exit() -> void:
	pass
	
func Process( _delta: float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * SPEED
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null
	
func Physics( _delta: float ) -> State:
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null
	
	
