extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

enum States {IDLE, RUNNING, JUMPING, FALLING, GLIDING}

@export var SPEED = 100.0
const JUMP_VELOCITY = -400.0

var state: States = States.IDLE
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var horizontal_d = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_d = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	var input_direction: = Vector2(horizontal_d, vertical_d)
		
	input_direction = input_direction.normalized()
	
	velocity= input_direction * SPEED
	move_and_slide()
	

	UpdateAnimation(horizontal_d, vertical_d)

func UpdateAnimation(horizontal_d, vertical_d = 0) -> void:
	if vertical_d != 0:
		if vertical_d == -1:
			animated_sprite.play("up")
		else:
			animated_sprite.play("down")
	elif horizontal_d != 0:
		#animated_sprite.flip_h = (horizontal_d == -1)
		if horizontal_d == -1:
			animated_sprite.play("left")
		else: 
			animated_sprite.play("right")
	else:
		animated_sprite.play("idle")
