extends Node2D

@export var player: CharacterBody2D

@export var button0: Area2D
@export var button1: Area2D
@export var button2: Area2D
@export var button3: Area2D
@export var button4: Area2D
@export var button5: Area2D
@export var button6: Area2D
@export var button7: Area2D
@export var button8: Area2D

@export var platform_1: StaticBody2D
@export var platform_2: StaticBody2D
@export var platform_3: StaticBody2D
@export var platform_4: StaticBody2D

@export var cannon0: Node2D	

@export var portal: Area2D

func _ready() -> void:
	if button0:
		button0.pressed.connect(_on_button0_pressed, CONNECT_ONE_SHOT)
	if button1:
		button1.pressed.connect(_on_button1_pressed, CONNECT_ONE_SHOT)
	
	if button2:
		button2.pressed.connect(_on_button2_pressed, CONNECT_ONE_SHOT)
	if button3:
		button3.pressed.connect(_on_button3_pressed, CONNECT_ONE_SHOT)

	if button4:
		button4.pressed.connect(_on_button4_pressed, CONNECT_ONE_SHOT)
	if button5:
		button5.pressed.connect(_on_button5_pressed, CONNECT_ONE_SHOT)
	
	if button6:
		button6.pressed.connect(_on_button6_pressed, CONNECT_ONE_SHOT)
	if button7:
		button7.pressed.connect(_on_button7_pressed, CONNECT_ONE_SHOT)

	if button8:
		button8.pressed.connect(_on_button8_pressed, CONNECT_ONE_SHOT)
	


func _on_button0_pressed() -> void:
	if player:
		player.jump_velocity = -400.0
	
	if button1:
		button1.deactivate()

func _on_button1_pressed() -> void:
	if player:
		player.speed = 250.0
	
	if button0:
		button0.deactivate()

func _on_button2_pressed() -> void:
	if platform_1:
		platform_1.start_moving()
	if platform_2:
		platform_2.start_moving()
	if platform_3:
		platform_3.start_moving()
	if platform_4:
		platform_4.start_moving()
	if button3:
			button3.deactivate()

func _on_button3_pressed() -> void:
	if player:
		player.die()
	if button2:
			button2.deactivate()

func _on_button4_pressed() -> void:
	if cannon0:
		cannon0.fire_interval = 100.0
	if button5:
			button5.deactivate()

func _on_button5_pressed() -> void:
	if cannon0:
		cannon0.fire_interval = 0.01
	if button4:
			button4.deactivate()

func _on_button6_pressed() -> void:

	if button7:
			button7.deactivate()

func _on_button7_pressed() -> void:
	if cannon0:
		cannon0.fire_interval = 0.01
	if button6:
			button6.deactivate()

func _on_button8_pressed() -> void:
	if portal:
		portal.open_portal()
