class_name Battle extends Control

signal textbox_closed


@export var walka : String = "walka_smog"
#@onready var enemy: Node2D = $Enemy


@onready var enemies: Node = $Enemies
var current_enemy: Node2D = null
var current_enemy_health = 0

var current_player_health = 0
var is_defending = false

func _ready():
	current_player_health = TestingPlayer.current_health
	set_health($PlayerPanel/PlayerData/ProgressBar, TestingPlayer.current_health, TestingPlayer.max_health)
	
	for e in enemies.get_children():
		e.visible = false
	
	if enemies.get_child_count() > 0:
		load_enemy(0)
	else:
		display_text("Nikogo nie ma...")
		return
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("Na drodze staje ci %s!" % current_enemy.enemy.name)
	await self.textbox_closed
	$ActionsPanel.show()

func load_enemy(index):
	#if current_enemy:
		#current_enemy.visible = false
		
	current_enemy = enemies.get_child(0)
	current_enemy.visible = true
	current_enemy.load_enemy()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$ActionsPanel.hide()
	$Textbox.show()
	$Textbox/Label.text = text

func enemy_turn():
	#var enemy = enemies[current_enemy_index]
	display_text("%s rzuca się na ciebie!" % current_enemy.enemy.name)
	await self.textbox_closed
	
	
	if is_defending:
		is_defending = false
		#$AnimationPlayer.play("mini_shake")
		#await $AnimationPlayer.animation_finished
		display_text("Udało ci się obronić!")
		await self.textbox_closed
	else:
		var le_dmg = current_enemy.deal_damage()
		print("Zadane obrażenia: ", le_dmg)
		current_player_health = max(0, current_player_health - le_dmg)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, TestingPlayer.max_health)
		#$AnimationPlayer.play("shake")
		#await $AnimationPlayer.animation_finished
		display_text("%s zadał %d obrażeń!" % [current_enemy.enemy.name, le_dmg])
		await self.textbox_closed
		
		if current_player_health == 0:
			on_defeat()
		
	$ActionsPanel.show()

func _on_Run_pressed():
	display_text("Uciekłeś!")
	await self.textbox_closed
	await get_tree().create_timer(0.25).timeout
	LevelManager.after_fight(walka, GameState.WALKA_STANY.UCIECZKA)
	
func on_victory():
	# Wszystkich pokonano
	display_text("Wszyscy wrogowie zostali pokonani!")
	await self.textbox_closed
	await get_tree().create_timer(0.25).timeout
	LevelManager.after_fight(walka, GameState.WALKA_STANY.WYGRANA)

func on_defeat():
	display_text("Przegrałeś!")
	await self.textbox_closed
	await get_tree().create_timer(0.25).timeout
	LevelManager.after_fight(walka, GameState.WALKA_STANY.PRZEGRANA)

func _on_Attack_pressed():
	display_text("Bierzesz zamach miotłą!")
	await self.textbox_closed
	
	var dealt_dmg = TestingPlayer.damage;
	# Odjęcie zdrowia przeciwnikowi
	var enemy_health = max(0, current_enemy.progress_bar.value - dealt_dmg)
	current_enemy.set_health(current_enemy.progress_bar, enemy_health, current_enemy.enemy.health)
	
	current_enemy.play_enemy_damaged()
	
	display_text("Zadano %d obrażeń!" % dealt_dmg)
	await self.textbox_closed
	
	if enemy_health == 0:
		display_text("%s został pokonany!" % current_enemy.enemy.name)
		await self.textbox_closed
		
		await current_enemy.play_enemy_died()
		
		enemies.remove_child(current_enemy)
		current_enemy.queue_free()
		
		if enemies.get_child_count() > 0:
			# Przejdź do następnego przeciwnika
			display_text("Kolejny przeciwnik nadciąga!")
			await self.textbox_closed
			$ActionsPanel.show()
			load_enemy(1)
		else:
			on_victory()
	else:
		enemy_turn()

func _on_Defend_pressed():
	is_defending = true
	
	display_text("Przygotowujesz się do obrony!")
	await self.textbox_closed
	
	await get_tree().create_timer(0.25).timeout
	
	enemy_turn()
