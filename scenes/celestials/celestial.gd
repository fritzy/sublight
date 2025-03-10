extends Node2D
class_name Celestial

@export var celestial_name := "???"
@export var celestial_body: ColorRect

signal updated_shader_parameters(values: Dictionary)

func set_shader_parameter(parameter: StringName, value: Variant) -> void:
	celestial_body.material.set_shader_parameter(parameter, value)