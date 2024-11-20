extends Node2D

@onready var anims: AnimationPlayer = $Anims
@onready var sprite: TextureRect = $EnemyContainer/Sprite
@onready var progress_bar: ProgressBar = $EnemyContainer/ProgressBar

@export var enemy: Resource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_enemy()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_enemy():
	set_health(progress_bar, enemy.health, enemy.health)
	sprite.texture = enemy.texture


func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]
	
func deal_damage() -> int:
	return enemy.damage
	
func play_enemy_died():
	anims.play("enemy_died")
	await anims.animation_finished
	print("death anim finished")
	
func play_enemy_damaged():
	anims.play("enemy_damaged")
	await anims.animation_finished
	print("damaged anim finished")
	
