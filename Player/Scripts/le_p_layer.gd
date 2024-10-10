extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

enum States {IDLE, RUNNING, JUMPING, FALLING, GLIDING}

@export var SPEED = 100.0
const JUMP_VELOCITY = -400.0

var state: States = States.IDLE
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		pass
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		pass
		#velocity.y = JUMP_VELOCITY
	
	var horizontal_d = Input.get_axis("left", "right")
	velocity.x = horizontal_d * SPEED
	
	var vertical_d = Input.get_axis("down", "up")
	velocity.y = -vertical_d * SPEED
	
	if horizontal_d != 0:
		animated_sprite.flip_h = (horizontal_d == -1)
		

	move_and_slide()
	UpdateAnimation(horizontal_d, vertical_d)

func UpdateAnimation(horizontal_d, vertical_d = 0) -> void:
	if vertical_d != 0:
		animated_sprite.play("up")
	elif horizontal_d != 0:
		animated_sprite.play("left")
	else:
		animated_sprite.play("idle")
