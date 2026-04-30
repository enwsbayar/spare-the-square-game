extends Node2D

@export var button1: Area2D
@export var button2: Area2D
@export var button3: Area2D
@export var button4: Area2D
@export var button5: Area2D
@export var button6: Area2D

@export var platform_1: StaticBody2D
@export var platform_2: StaticBody2D
@export var platform_3: StaticBody2D
@export var platform_4: StaticBody2D
@export var platform_5: StaticBody2D
@export var platform_6: StaticBody2D

@export var npc_3: CharacterBody2D

@export var portal: Area2D

func _ready() -> void:
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
	if npc_3:
		npc_3.died.connect(_on_npc_died, CONNECT_ONE_SHOT)


func _on_button1_pressed() -> void:
	if platform_1:
		platform_1.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()

func _on_button2_pressed() -> void:
	if platform_2:
		platform_2.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()

func _on_button3_pressed() -> void:
	if platform_3:
		platform_3.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()

func _on_button4_pressed() -> void:
	if platform_4:
		platform_4.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()

func _on_button5_pressed() -> void:
	if platform_5:
		platform_5.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()

func _on_button6_pressed() -> void:
	if platform_6:
		platform_6.start_moving()
		button1.deactivate()
		button2.deactivate()
		button3.deactivate()
		button4.deactivate()
		button5.deactivate()
		button6.deactivate()
	
func _on_npc_died() -> void:
	if portal:
		portal.open_portal()