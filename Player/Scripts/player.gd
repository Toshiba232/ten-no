class_name Player extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine

@onready var actionable_finder: Area2D = $Interactions/ActionableFinder

signal DirectionChanged( new_direction : Vector2 )

var cardinal_direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO

var can_move = true
var can_pause = true

func _ready() -> void:
	add_to_group("player")
	
	state_machine.Initialize(self)
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		var actonables = actionable_finder.get_overlapping_areas()
		if actonables.size() > 0:
			actonables[0].DialogStarted.connect(_on_dialog_started)
			actonables[0].DialogFinished.connect(_on_dialogue_finished)
			actonables[0].action()
			
			return
			
func _physics_process(_delta: float) -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = direction.normalized()

	move_and_slide()

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
		
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]
		
	#if direction.y == 0:
		#new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#elif direction.x == 0:
		#new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit( new_dir )
	return true

func UpdateAnimation( state : String ) -> void:
	animated_sprite.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	#if cardinal_direction == Vector2.DOWN:
		#return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		return "down"

func _on_dialog_started():
	print("Dialog się rozpoczął!")
	can_move = false
	can_pause = false
	
	print("can move: " + str(can_move))
	
func _on_dialogue_finished():
	print("Zakończono dialog")
	can_move = true
	can_pause = true

	pass


func move_cutscene(move: Vector2):
	position += move
