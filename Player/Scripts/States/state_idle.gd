class_name State_Idle extends State

@onready var walk: State = $"../Walk"

## Ustala, co się dzieje z graczem w tym stanie
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

## Ustala, co się dzieje przy wyjściu ze stanu
func Exit() -> void:
	pass
	
func Process( _delta: float ) -> State:
	if player.direction != Vector2.ZERO and player.can_move:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func Physics( _delta: float ) -> State:
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null
	
	
