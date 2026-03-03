class_name State
extends Node

var actor: CharacterBody2D

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_default(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
