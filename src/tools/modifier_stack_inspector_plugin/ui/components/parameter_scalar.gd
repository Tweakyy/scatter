tool
extends HBoxContainer


signal value_changed


var _is_int := false

onready var _label: Label = $Label
onready var _spinbox: SpinBox = $MarginContainer/MarginContainer/SpinBox


func _ready() -> void:
	_spinbox.connect("value_changed", self, "_on_value_changed")
	mark_as_int(_is_int)


func mark_as_int(val: bool) -> void:
	_is_int = val
	if _is_int and _spinbox:
		_spinbox.step = 1


func set_parameter_name(text: String) -> void:
	_label.text = text


func set_value(val) -> void:
	if _is_int:
		val = int(val)
	_spinbox.set_value(val)


func get_value():
	if _is_int:
		return int(_spinbox.get_value())
	return _spinbox.get_value()


func _on_value_changed(value) -> void:
	emit_signal("value_changed", value)
