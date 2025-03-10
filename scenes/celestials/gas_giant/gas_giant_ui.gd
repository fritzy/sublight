extends BaseCelestialUI

@onready var axis_slider:HSlider = %Axis
@onready var orbit_slider:HSlider = %Orbit
@onready var lock_camera:CheckButton = %LockCamera

@export var orbit := 0.0:
	set(value):
		orbit = value
		_update_planet()
@export var axis := 0.0:
	set(value):
		axis = value
		_update_planet()
@export var lock_axis := false:
	set(value):
		lock_axis = value
		_update_planet()

func _ready() -> void:
	axis_slider.value_changed.connect(func(value: float): axis = value)
	orbit_slider.value_changed.connect(func(value: float): orbit = value)
	resized.connect(_update_planet)
	%LockCamera.toggled.connect(func(value: bool): lock_axis = value)
	button_map = {
		%JupiterButton: &"set_jupiter_gradient",
		%NeptuneButton: &"set_neptune_gradient",
		%SaturnButton: &"set_saturn_gradient",
	}
	parameter_map = {
		&"intensity": %TurbulenceSlider,
	}
	super()

func _update_planet() -> void:
	#var sun_pos := Vector3(cos(axis) * sin(orbit), sin(axis) * sin(orbit), cos(orbit))
	update_shader_parameter.emit(&"axis", axis)
	update_shader_parameter.emit(&"orbit", orbit)
	if lock_axis:
		update_axis.emit(axis)
	else:
		update_axis.emit(0.0)
	%SunGizmo.update(axis, orbit, lock_axis)
